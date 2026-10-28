import 'dart:js_interop';

import 'package:flutter/foundation.dart';

/// Sends [message] to the page that embeds the demo. Only a page of the same origin receives it.
void postToHost(Map<String, Object?> message) => _window.parent?.postMessage(message.jsify(), _window.location.origin);

/// Calls [onMessage] with the data of every message from the page that embeds the demo. Returns a function that
/// stops listening.
///
/// Messages from another origin, or from any window but the parent, are ignored.
VoidCallback listenToHost(void Function(Object? data) onMessage) {
  final listener = ((_MessageEvent event) {
    final parent = _window.parent;
    if (event.origin != _window.location.origin || parent == null || !parent.strictEquals(event.source).toDart) {
      return;
    }

    onMessage(event.data.dartify());
  }).toJS;

  _window.addEventListener('message', listener);

  return () => _window.removeEventListener('message', listener);
}

@JS('window')
external _Window get _window;

extension type _Window._(JSObject _) implements JSObject {
  external _Window? get parent;
  external _Location get location;
  external void postMessage(JSAny? message, String targetOrigin);
  external void addEventListener(String type, JSFunction listener);
  external void removeEventListener(String type, JSFunction listener);
}

extension type _Location._(JSObject _) implements JSObject {
  external String get origin;
}

extension type _MessageEvent._(JSObject _) implements JSObject {
  external String get origin;
  external JSAny? get source;
  external JSAny? get data;
}
