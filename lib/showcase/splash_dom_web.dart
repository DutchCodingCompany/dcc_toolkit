import 'dart:async';
import 'dart:js_interop';

const _splashId = 'splash';
const _hiddenClass = 'splash--hidden';
const _removeDelay = Duration(seconds: 1);

/// In the browser the splash of `web/index.html` can be removed.
const bool hasSplashDom = true;

/// How long the page has been loading.
Duration timeSincePageLoad() => Duration(microseconds: (_performance.now() * 1000).round());

/// Fades the splash out and removes it from the page.
void hideSplashDom() {
  final splash = _document.getElementById(_splashId);
  if (splash == null) return;

  splash.classList.add(_hiddenClass);
  // Interop members can not be torn off.
  // ignore: unnecessary_lambdas
  Timer(_removeDelay, () => splash.remove());
}

@JS('document')
external _Document get _document;

@JS('performance')
external _Performance get _performance;

extension type _Document._(JSObject _) implements JSObject {
  external _Element? getElementById(String id);
}

extension type _Performance._(JSObject _) implements JSObject {
  external double now();
}

extension type _Element._(JSObject _) implements JSObject {
  external _ClassList get classList;
  external void remove();
}

extension type _ClassList._(JSObject _) implements JSObject {
  external void add(String token);
}
