import 'package:dcc_toolkit/logger/charges/bolt_charge.dart';
import 'package:dcc_toolkit/logger/util/ansi_support.dart'
    if (dart.library.io) 'package:dcc_toolkit/logger/util/ansi_support_io.dart'
    if (dart.library.html) 'package:dcc_toolkit/logger/util/ansi_support_web.dart';
import 'package:dcc_toolkit/logger/zap_event.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// {@template debug_console_charge}
/// A [BoltCharge] that logs output to the console with ANSI color support.
/// {@endtemplate}
class DebugConsoleCharge implements BoltCharge {
  /// {@macro debug_console_charge}
  const DebugConsoleCharge();
  @override
  String get name => 'DebugConsoleCharge';

  @override
  void logOutput(ZapEvent event) {
    if (!kDebugMode) return;
    _paintLines(event).forEach(debugPrint);
  }

  List<String> _paintLines(ZapEvent event) {
    final shouldPaint = supportsAnsiEscapes &&
        (event.origin.level.value >= Level.SEVERE.value ||
            event.origin.stackTrace != null ||
            event.origin.error != null);

    return shouldPaint
        ? event.lines.map((line) => '$_red$line$_reset').toList()
        : event.lines;
  }

  @override
  void discharge() {}
}

const _esc = '\x1B[';
const _reset = '${_esc}0m';
const _red = '${_esc}38;5;1m';
