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
  late final DemoState _demo = DemoState(config: widget.config);

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
        builder: (context, child) => ShowcaseShell(child: child!),
      ),
    );
  }
}
```

- **`ShowcaseState`** holds what the demo remembers. Extend it with the data of your app and call
  `notifyListeners()` when it changes. Read it with `ShowcaseScope.of<DemoState>(context)`.
- **`ShowcaseNavigator`** navigates with the plain Flutter `Navigator`, so the url of the browser never changes.
  The pages are the values of an enum, opened with `context.showcase.push(DemoPage.detail, args: id)`.
- **`ShowcaseShell`** adds the safe areas that the config asks for and shows notices above everything else.
- **`ShowcaseStrings`** holds the texts of the kit. The defaults are English, pass your own to `ShowcaseScope`.

## Highlights

A `Highlight` explains part of a screen with a card. The app is dimmed around the target, which gets a ring and stays
usable; touches anywhere else are stopped until the explanation is closed. The real views do not change for the
showcase, so the target is found in the widget tree:

```dart
Highlight(
  title: 'Your balance',
  body: 'Grows with every scan.',
  target: Highlight.type<BalanceWidget>(),
)
```

Explanations never open by themselves. The visitor opens the one of the page on screen with a small info button, and
it starts at the first step every time.

The explanations and the notices are in the style of Dutch Coding Company, not of the app. Their sizes come from the
Figma design of the DCC website, which shows the phone at 90%; they are divided by that, so they match the design
there. Declare DM Sans in the pubspec of the
showcase and pass its family name to `ShowcaseScope(fontFamily: 'DM Sans')`.

### Starting them from the website

With `?tour=host` the info button is left out, and the website starts the explanations with a button of its own.
`ShowcaseShell` connects the two with `postMessage`, on the same origin only:

- the demo sends `{type: 'showcase:tour', canStart: bool}` at the start and whenever it changes. Enable the button
  only while `canStart` is true: the page on screen has an explanation, it is not open, and no sheet or dialog
  covers it (also not one in the root navigator);
- the website sends `{type: 'showcase:start-tour'}` to the frame to open it.

`ShowcaseState.tour` is the same switch in Dart, for tests or a button of your own.

## Out of scope

Call `context.showOutOfScope('Payout')` for a part of the app that is not in the demo. It shows a notice for a
moment.

## Splash

Like the native splash on a phone, the demo shows a splash while it loads. Put it in `web/index.html` as an
element with id `splash`, with the color and logo of the app, so it is there before Flutter has loaded:

```html
<style>
  #splash { position: fixed; inset: 0; z-index: 9999; display: flex; align-items: center; justify-content: center;
            background: #FFFFFF; transition: opacity 300ms; }
  #splash img { width: 192px; }
  #splash.splash--hidden { opacity: 0; pointer-events: none; }
  /* Keeps a scroll over the embedded demo inside it, instead of scrolling the website once the app has none left. */
  html, body { overscroll-behavior: none; }
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
| `tour=host`      | Leaves starting the explanations to the website, see above.           |
