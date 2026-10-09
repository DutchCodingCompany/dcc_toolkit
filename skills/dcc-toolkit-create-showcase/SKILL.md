---
name: dcc-toolkit-create-showcase
description: Set up a clickable web demo (showcase) of a Flutter app with the dcc_toolkit showcase kit, built from the app's real views with dummy data, highlights that explain screens, out-of-scope notices and a story that can start over. Use when creating a showcase or demo app, adding screens or explanations to an existing showcase, or embedding an app demo on a website.
metadata:
  last_modified: "2026-10-09"
---

# Create a Showcase

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Core Concepts](#core-concepts)
- [Workflow](#workflow)
- [Common Patterns](#common-patterns)
- [Pitfalls](#pitfalls)
- [Feedback Loop](#feedback-loop)

## Overview

A showcase is a separate Flutter **web** app (`apps/showcase` in a DCC mono repo) that shows the real app on a
website. It reuses the views from `packages/base` and feeds them fixed dummy data, so there is no backend, Firebase,
camera or login. The visitor clicks through one short story; explanations ("highlights") appear on top of the real
screens without changing them.

The kit lives in `dcc_toolkit` behind its own entrypoint:

```dart
import 'package:dcc_toolkit/showcase.dart';
```

Reference implementations: `apps/showcase` in the Statieheld project (full story) and in bolt_core (minimal
skeleton).

## Prerequisites

- Flutter >=3.47.0, Dart ^3.13.0, `dcc_toolkit` >=0.1.1, the app migrated to `material_ui`
  (see `doc/migrate_to_material_ui.md`).
- The app's screens are split into a **page** (cubit, DI, routing) and a **view** (plain widget with data and
  callbacks). The showcase only uses views. A screen without a separate view has to be split first.
- `just/showcase.just` from just-flutter, imported in the `justfile`: `import? 'just/showcase.just'`. It provides
  `just run_showcase` and `just build_showcase` (no CDN, `SHOWCASE_BASE_HREF` for a sub path).

## Core Concepts

| API | Role |
|-----|------|
| `ShowcaseState` | Abstract `ChangeNotifier` with what every demo remembers. Extend it with the data of the app. Implement `resetData()`. Call `begin()` when a flow starts and `finish()` at the end of the story |
| `ShowcaseScope` | `InheritedNotifier` above `MaterialApp`. Props: `state`, `strings`, `noticeBuilder`. Read with `ShowcaseScope.of<DemoState>(context, listen: false)` |
| `ShowcaseNavigator<P extends Enum>` | Plain `Navigator` for the demo, put as `home` of `MaterialApp`. Props: `home`, `builder(context, page, args)`, `highlights(context, page, state)`. The browser url never changes |
| `context.showcase` | `push(page, args:)`, `replace`, `pop`, `popToHome`, `pushOnHome` |
| `Highlight` | One explanation: `title`, `body`, optional `target` (a `WidgetMatcher`), `padding`. `Highlight.type<T>()` matches the first widget of type `T` |
| `FinishPrompt` | Wrap home in it. Once the demo is finished it offers to start over |
| `context.showOutOfScope([feature])` | Shows a "not in this demo" notice |
| `ShowcaseShell` | For `MaterialApp.builder`: adds `insets` and shows notices above everything |
| `ShowcaseConfig.fromUri` | Reads `?highlights=off` and `?insets=ios` from the url |
| `ShowcaseStrings` | All texts of the kit, English by default |

Behaviour worth knowing:

- A page explains itself **once** (per page and first highlight title). After that the explanation waits behind a
  small info button. This survives a restart of the demo.
- A highlight whose target is not built yet waits for it, and the target is scrolled into view.
- After `finish()`, `FinishPrompt` shows a dialog on home. "Keep looking" closes it; the next `begin()` then resets
  the demo by itself.

## Workflow

**Task Progress:**
- [ ] 1. Create `apps/showcase` and add it to the workspace
- [ ] 2. Write `DemoState` with the dummy data and the story
- [ ] 3. List the screens in a `DemoPage` enum with a `ShowcaseNavigator`
- [ ] 4. Build each page from a base view, fed by `DemoState`
- [ ] 5. Add highlights
- [ ] 6. Wire up `ShowcaseApp` and `main.dart`
- [ ] 7. Add `web/index.html` with a strict CSP
- [ ] 8. Test and build for web

### Step 1: Create the app

`apps/showcase/pubspec.yaml`:

```yaml
name: showcase
description: "Clickable demo of the app, built from the real views in the base package."
publish_to: 'none'
version: 0.1.0
resolution: workspace

environment:
  sdk: ^3.13.4
  flutter: ">=3.47.5"

dependencies:
  base:
  dcc_toolkit: any
  flutter:
    sdk: flutter
  google_fonts: any # only when base uses google_fonts
  intl: any
  material_ui: any

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis: 11.0.0

flutter:
  uses-material-design: true
```

Add `- apps/showcase` to `workspace:` in the root `pubspec.yaml`, copy `analysis_options.yaml` from another app and
run `fvm flutter pub get`.

### Step 2: DemoState

The state replaces the backend. Keep the story short and decide where it ends.

```dart
import 'package:dcc_toolkit/showcase.dart';
import 'package:material_ui/material_ui.dart';

const _startBalance = 12.50;

/// In-memory state of the demo. The story ends after a donation.
class DemoState({super.highlightsEnabled}) extends ShowcaseState {
  double balance = _startBalance;

  static DemoState of(BuildContext context, {bool listen = true}) =>
      ShowcaseScope.of<DemoState>(context, listen: listen);

  void scan() {
    begin();
    balance += 0.45;
    notifyListeners();
  }

  void donate() {
    begin();
    balance = 0;
    finish(); // notifies
  }

  @override
  void resetData() => balance = _startBalance;
}
```

Call `begin()` at the start of every action, so a finished demo starts over by itself.

### Step 3: DemoPage

```dart
enum DemoPage {
  home,
  donate;

  static Widget navigator() => ShowcaseNavigator<DemoPage>(
    home: home,
    builder: (context, page, args) => switch (page) {
      home => const HomePage(),
      donate => const DonatePage(),
    },
    highlights: (context, page, state) => highlightsFor(page, state as DemoState),
  );
}
```

Pass arguments with `context.showcase.push(DemoPage.detail, args: id)` and read them as `args! as String` in the
builder.

### Step 4: Pages from base views

Never use the app's pages: they need DI, cubits, a router and the network. Wrap the **view** instead:

```dart
class const HomePage() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final demo = DemoState.of(context);

    return FinishPrompt(
      child: Scaffold(
        body: HomeView(
          balance: demo.balance,
          onScanPressed: DemoState.of(context, listen: false).scan,
          onDonatePressed: () => context.showcase.push(DemoPage.donate),
          onPayoutPressed: () => context.showOutOfScope('Uitbetalen'),
        ),
      ),
    );
  }
}
```

- Read with `listen: true` in `build`, with `listen: false` in callbacks.
- Every callback either works with dummy data or calls `context.showOutOfScope(...)`. Nothing may hit the network.
- At the end of a flow use `context.showcase.pushOnHome(...)` or `popToHome()`, so back leads home and not into the
  flow again.

### Step 5: Highlights

```dart
List<Highlight> highlightsFor(DemoPage page, DemoState demo) => switch (page) {
  DemoPage.home => [
    const Highlight(title: 'Welkom', body: 'Dit zijn de echte schermen van de app.'),
    Highlight(
      title: 'Je saldo',
      body: 'Groeit bij elke scan.',
      target: Highlight.type<BalanceWidget>(),
    ),
  ],
  DemoPage.donate => const [],
};
```

- `Highlight.type<T>()` matches the **first** widget of that type. For a more specific match write a matcher:
  `bool _isScanButton(Widget w) => w is SButton && w.width == SDimensions.scanButtonSize;`
- Highlights may depend on `demo` (for example a different text after the first scan). A changed first title counts
  as a new explanation and opens again.
- Keep the texts short and in the language of the app.

### Step 6: ShowcaseApp and main

```dart
class const ShowcaseApp({required final ShowcaseConfig config, super.key}) extends StatefulWidget {
  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  late final DemoState _demo = DemoState(highlightsEnabled: widget.config.highlightsEnabled);

  @override
  void dispose() {
    _demo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseScope(
      state: _demo,
      strings: dutchStrings,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: const CoreTheme().light,
        localizationsDelegates: const [AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates],
        supportedLocales: AppLocalizations.supportedLocales,
        home: DemoPage.navigator(),
        builder: (context, child) => ShowcaseShell(insets: widget.config.insets, child: child!),
      ),
    );
  }
}
```

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false; // fonts are bundled, the CSP blocks fetching
  await initializeDateFormatting();

  runApp(ShowcaseApp(config: ShowcaseConfig.fromUri(kIsWeb ? Uri.base : Uri())));
}
```

Dutch texts for the kit:

```dart
String _featureOutOfScope(String feature) => '$feature valt buiten deze demo.';

const dutchStrings = ShowcaseStrings(
  next: 'Volgende',
  done: 'Klaar',
  explanation: 'Uitleg',
  outOfScope: 'Dit onderdeel valt buiten deze demo.',
  featureOutOfScope: _featureOutOfScope,
  finishTitle: 'Demo afgerond',
  finishMessage: 'Je hebt het hele verhaal gezien. Wil je opnieuw beginnen?',
  keepLooking: 'Blijf rondkijken',
  startOver: 'Opnieuw beginnen',
);
```

Pass `noticeBuilder: (context, text) => AppSnackbar(text: text)` to `ShowcaseScope` to make notices look like the app.
On desktop a mouse should drag-scroll like a finger: give `MaterialApp` a `scrollBehavior` that adds
`PointerDeviceKind.mouse` to `dragDevices`.

### Step 7: web/index.html

Plugins pulled in through `base` (Mixpanel, Firebase, Sentry, Google Sign-In) must not load third-party scripts or
send data. Allow only the own origin:

```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Security-Policy"
        content="default-src 'self'; script-src 'self' 'wasm-unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: blob:; font-src 'self' data:; connect-src 'self' blob: data:; worker-src 'self' blob:">
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="favicon.png"/>
  <title>App showcase</title>
</head>
<body>
  <script src="flutter_bootstrap.js" async></script>
</body>
</html>
```

Dummy images go in `web/` (loaded same-origin) or `assets/`.

### Step 8: Test and build

See [Feedback Loop](#feedback-loop).

## Common Patterns

### Tabs or a bottom bar

Keep the selected tab in `DemoState` (for example `StatieheldTab tab`) and switch views on it in the home page. Make
the highlights depend on the tab.

### Embedding on a website

Embed the build in an iframe inside a phone frame. Use `?insets=ios` when the frame has no status bar of its own,
`?highlights=off` for a silent version. Build with `SHOWCASE_BASE_HREF=/showcase/ just build_showcase` when it is not
served from the root.

### Easter eggs and extra apps

Any widget can be a page, for example a mini game from another workspace app:
`game => Game(onClose: () => unawaited(context.showcase.pop()))`.

## Pitfalls

- **`dart:ffi` is not available on this platform.** Something reachable from a base view imports a native-only
  package (`cronet_http`, `cupertino_http`, `objective_c`). Follow the import chain in the error. Usual fix in base: a
  conditional import for the HTTP client
  (`import 'client_factory_native.dart' if (dart.library.js_interop) 'client_factory_web.dart';`, with `BrowserClient`
  from `package:http` on web). Generated routers (`app_router.gr.dart`) import every page, so a view that imports the
  router pulls in the whole app.
- **"No MaterialLocalizations found" or a missing dialog.** The generated `AppLocalizations.localizationsDelegates`
  provide the legacy `flutter/material` localizations. With `material_ui` use
  `[AppLocalizations.delegate, ...GlobalMaterialLocalizations.delegates]`.
- **Null check in `context.katjasBoekwerk`.** The theme lacks the `KatjasBoekwerk` extension; add it to the theme (see
  the `dcc-toolkit-setup-kleurplaat-boekwerk` skill).
- **A view navigates by itself** (for example `context.router.push(...)` from auto_route). There is no router in the
  showcase, so that throws. Make the navigation a callback of the view, or leave that gesture out.
- **Fonts missing or blocked.** `google_fonts` fetches at runtime unless `allowRuntimeFetching = false` and the fonts
  are bundled as assets.
- **Legacy dependencies still on `flutter/material`.** Wrap the app in `MaterialUiCompatibilityBridge` in
  `MaterialApp.builder` until they migrate.
- **Stale build in the browser.** Flutter web caches aggressively; add a dummy query parameter when checking a new
  build.

## Feedback Loop

1. `fvm dart analyze apps/showcase` -- no issues.
2. Unit test `DemoState`: start values, each action, `finish()`, and that `begin()` after finishing resets the data.
3. Widget test the story, with highlights off:

   ```dart
   testWidgets('offers to start over after donating', (tester) async {
     await tester.pumpWidget(const ShowcaseApp(config: ShowcaseConfig(highlightsEnabled: false)));
     await tester.pumpAndSettle();

     // ... tap through the story

     await tester.pumpAndSettle(const Duration(seconds: 1));
     expect(find.text(dutchStrings.finishTitle), findsOneWidget);
   });
   ```

4. `just build_showcase` -- the web build must compile (this is where `dart:ffi` problems show up).
5. Serve `apps/showcase/build/web` locally and click through the story in a browser: highlights open once, the ring
   sits on the right widget, out-of-scope notices appear, and the finish dialog offers to start over.
