import 'package:flutter/foundation.dart';

/// Sends [message] to the page that embeds the demo.
void postToHost(Map<String, Object?> message) {}

/// Calls [onMessage] with the data of every message from the page that embeds the demo. Returns a function that
/// stops listening.
VoidCallback listenToHost(void Function(Object? data) onMessage) => () {};
