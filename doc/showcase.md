# Showcase

Building blocks for a clickable demo of an app, made from its real screens. The demo runs as a Flutter web app,
usually embedded on a website, fed with fixed dummy data instead of a backend.

```dart
import 'package:dcc_toolkit/showcase.dart';
```

It is a separate entrypoint, so apps that do not have a showcase do not see any of it.

## Setup

```dart
void main() => runApp(ShowcaseApp(ShowcaseConfig.fromUri(kIsWeb ? Uri.base : Uri())));

class _ShowcaseAppState extends State<ShowcaseApp> {
  late final DemoState _demo = DemoState(highlightsEnabled: widget.config.highlightsEnabled);

  @override
  Widget build(BuildContext context) {
    return ShowcaseScope(
      state: _demo,
      child: MaterialApp(
        home: ShowcaseNavigator<DemoPage>(
          home: DemoPage.home,
          builder: (context, page, args) => switch (page) {
            DemoPage.home => const HomePage(),
            DemoPage.detail => DetailPage(id: args! as String),
          },
          highlights: (context, page, state) => highlightsFor(page, state as DemoState),
        ),
        builder: (context, child) => ShowcaseShell(insets: widget.config.insets, child: child!),
      ),
    );
  }
}
```

- **`ShowcaseState`** holds what the demo remembers. Extend it with the data of your app and put that data back
  at the start in `resetData`. Read it with `ShowcaseScope.of<DemoState>(context)`.
- **`ShowcaseNavigator`** navigates with the plain Flutter `Navigator`, so the url of the browser never changes.
  The pages are the values of an enum, opened with `context.showcase.push(DemoPage.detail, args: id)`.
- **`ShowcaseShell`** adds the safe areas that the config asks for and shows notices above everything else.
- **`ShowcaseStrings`** holds the texts of the kit. The defaults are English, pass your own to `ShowcaseScope`.
  Pass `noticeBuilder` to make notices look like the snackbars of the app.

## Highlights

A `Highlight` explains part of a screen with a pulsing ring around the target and a small card, without dimming
the app. The real views do not change for the showcase, so the target is found in the widget tree:

```dart
Highlight(
  title: 'Your balance',
  body: 'Grows with every scan.',
  target: Highlight.type<BalanceWidget>(),
)
```

A page explains itself once. After that, the explanation waits behind a small info button.

## The story

- Call `begin()` on the state when a visitor starts a flow, and `finish()` at the end of the story.
- Wrap home in `FinishPrompt`: back on home it offers to start over. When the visitor keeps looking around, the demo
  starts over by itself at the next `begin()`.
- Call `context.showOutOfScope('Payout')` for a part of the app that is not in the demo.

## Splash

Like the native splash on a phone, the demo shows a splash while it loads. Put it in `web/index.html` as an
element with id `splash`, with the color and logo of the app, so it is there before Flutter has loaded:

```html
<style>
  #splash { position: fixed; inset: 0; z-index: 9999; display: flex; align-items: center; justify-content: center;
            background: #FFFFFF; transition: opacity 300ms; }
  #splash img { width: 192px; }
  #splash.splash--hidden { opacity: 0; pointer-events: none; }
</style>
...
<body>
  <div id="splash"><img src="splash/logo.png" alt=""></div>
  <script src="flutter_bootstrap.js" async></script>
</body>
```

Remove it after `runApp`:

```dart
runApp(ShowcaseApp(config: config));
unawaited(removeShowcaseSplash(minimum: config.splashEnabled ? const Duration(seconds: 2) : Duration.zero));
```

The splash stays until the app is drawn and at least `minimum` has passed since the page started loading, then fades
out with the class `splash--hidden`. Keep the transition under a second, the element is removed after that.

## Url parameters

`ShowcaseConfig.fromUri` lets the website configure the demo:

| Parameter        | Effect                                                                |
|------------------|-----------------------------------------------------------------------|
| `highlights=off` | Hides the explanations.                                               |
| `insets=ios`     | Adds the safe areas of an iPhone, for embedding without a status bar. |
| `splash=off`     | Removes the splash as soon as the app is drawn.                       |
