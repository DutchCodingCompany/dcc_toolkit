import 'dart:async';

import 'package:dcc_toolkit/logger/charges/bolt_charge.dart';
import 'package:dcc_toolkit/logger/charges/debug_console_charge.dart';
import 'package:dcc_toolkit/logger/charges/file_charge.dart';
import 'package:dcc_toolkit/logger/charges/memory_charge.dart';
import 'package:dcc_toolkit/logger/zap_event.dart';
import 'package:logging/logging.dart';

/// {@template bolt_logger}
/// Super charge your logging and zap logs like Zeus with the BoltLogger.
/// {@endtemplate}
class BoltLogger {
  /// {@macro bolt_logger}
  factory BoltLogger() => _instance;

  BoltLogger._();

  static final _instance = BoltLogger._();

  StreamSubscription<LogRecord>? _subscription;

  final Map<String, BoltCharge> _outputs = {};

  /// Add [BoltCharge] charges to the logger. This will start the logger if it is not already running.
  /// Without any charges, the logger will not output any logs.
  ///
  /// Available charges:
  /// - [DebugConsoleCharge]
  /// - [MemoryCharge]
  /// - [FileCharge]
  ///
  /// For example to add a [DebugConsoleCharge] charge, use the following code snippet:
  /// ```dart
  /// BoltLogger.charge([DebugConsoleCharge()]);
  /// ```
  static void charge(List<BoltCharge> charges) {
    for (final charge in charges) {
      _instance._outputs.putIfAbsent(charge.name, () => charge);
    }
    _instance._subscribeIfNeeded();
  }

  /// Look up registered charge by name.
  static BoltCharge? getCharge(String name) {
    return _instance._outputs[name];
  }

  void _subscribeIfNeeded() {
    Logger.root.level = Level.ALL;
    _subscription ??= Logger.root.onRecord.listen((record) {
      for (final output in _outputs.values) {
        output.logOutput(ZapEvent.fromRecord(record));
      }
    });
  }

  /// Discharge the logger and all charges.
  void discharge() {
    _subscription?.cancel();
    _subscription = null;
    for (final output in _outputs.values) {
      output.discharge();
    }
    _outputs.clear();
  }

  /// {@template zap}
  /// Zap a log message with optional [tag] and [level].
  ///
  /// For example to zap a message:
  /// ```dart
  /// BoltLogger.zap('Electricity is in the air!');
  /// ```
  ///
  /// The [message] can also be an [Exception]/[Error], [StackTrace] or a [List] to zap all 3 types ([Object]?, [Exception]/[Error], [StackTrace]). These will be passed to the logger.
  ///
  /// ```dart
  /// BoltLogger.zap(['Electricity is in the air!', myException, stackTrace]);
  /// ```
  ///
  /// {@endtemplate}
  static void zap(
    Object? message, {
    String? tag,
    Level level = Level.INFO,
  }) {
    Object? msg;
    Object? error;
    StackTrace? stacktrace;

    void zapMap(Object? value) {
      if (value is Exception || value is Error && error == null) {
        error = value;
      } else if (value is StackTrace && stacktrace == null) {
        stacktrace = value;
      } else if (msg == null) {
        msg = value;
      } else {
        final errorMessage =
            'When zapping a list it can only contain one of each Exception/Error, StackTrace or Object?: $message';
        assert(false, errorMessage);
        error = AssertionError([errorMessage]);
        msg = '';
        stacktrace = StackTrace.empty;
      }
    }

    if (message is List) {
      for (final Object? value in message) {
        zapMap(value);
      }
    }else {
      zapMap(message);
    }

    Logger(tag ?? 'BoltLogger').log(level, msg, error, stacktrace);
  }

  /// {@template shock}
  /// Shock is a zap intensified! It zaps a log message default [level] of [Level.SEVERE].
  ///
  /// {@macro zap}
  ///
  /// {@endtemplate}
     static void shock(
      Object? message, {
        String? tag,
        Level level = Level.SEVERE,
      }) {
    zap(message, tag: tag, level: level);
     }
}
