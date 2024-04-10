import 'dart:async';

import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:flutter/widgets.dart';

/// A function that handles errors.
typedef OnError = void Function(Object error, StackTrace? stackTrace);

/// Run a Flutter app with a bootstrap that catches errors.
/// By default [onError] will use BoltLogger to log the error.
Future<void> runAppBootstrap(Future<Widget> Function() builder,
    {OnError? onError}) async {
  final errorLogger = onError ??
      (exception, stackTrace) {
        BoltLogger.shock([exception, stackTrace]);
      };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError =
          (details) => errorLogger(details.exception, details.stack);

      runApp(await builder());
    },
    errorLogger,
  );
}
