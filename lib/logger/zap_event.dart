import 'package:dcc_toolkit/logger/log_record_formatter.dart';
import 'package:logging/logging.dart';
/// {@template zap_event}
/// A zap event that contains the [lines] of a log record and the [origin] [LogRecord].
/// {@endtemplate}
class ZapEvent {
  /// {@macro zap_event}
  const ZapEvent._(this.lines, this.origin);

  /// Create a [ZapEvent] from a [LogRecord].
  factory ZapEvent.fromRecord(LogRecord record) {
    final lines = const LogRecordFormatter().format(record);
    return ZapEvent._(lines, record);
  }

  /// The original [LogRecord] that was zapped.
  final LogRecord origin;

  /// Formatted lines of the [LogRecord].
  final List<String> lines;
}
