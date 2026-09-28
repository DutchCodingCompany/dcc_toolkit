import 'package:dcc_toolkit/logger/log_record_formatter.dart';
import 'package:logging/logging.dart';

/// {@template zap_event}
/// A zap event that contains the [lines] of a log record and the [origin] [LogRecord].
/// {@endtemplate}
class const ZapEvent._(
  /// Formatted lines of the [LogRecord].
  final List<String> lines,

  /// The original [LogRecord] that was zapped.
  final LogRecord origin,
) {
  /// {@macro zap_event}
  this;

  /// Create a [ZapEvent] from a [LogRecord].
  factory ZapEvent.fromRecord(LogRecord record) {
    final lines = const LogRecordFormatter().format(record);
    return ZapEvent._(lines, record);
  }
}
