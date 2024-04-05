import 'package:dcc_toolkit/logger/extensions/stacktrace.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

/// {@template log_record_formatter}
/// A formatter that formats a [LogRecord] into a list of strings.
/// {@endtemplate}
class LogRecordFormatter {
  /// {@macro log_record_formatter}
  const LogRecordFormatter();

  static final DateFormat _formatter = DateFormat(DateFormat.HOUR24_MINUTE);

  /// Format the [record] into a list of strings.
  List<String> format(LogRecord record) {
    final lines = <String>[];
    final prefix = _prefix(record);

    lines
      ..addAll(_formatMessage(record))
      ..addAll(_formatErrors(record))
      ..addAll(_formatStacktrace(record));

    return lines.map((e) => '$prefix$e').toList();
  }

  List<String> _formatMessage(LogRecord record) {
    if (record.message == 'null'|| record.message.trim().isEmpty) return [];

    return record.message.split('\n');
  }

  List<String> _formatErrors(LogRecord record) {
    if (record.error == null) return [];

    return record.error.toString().split('\n').map((e) => e.trim()).toList();
  }

  List<String> _formatStacktrace(LogRecord record) => record.stackTrace?.strike.split('\n') ?? [];

  String _prefix(LogRecord record) {
    final tag = record.loggerName;
    final level = record.level.name.substring(0, 1);
    final time = _formatter.format(record.time);
    return '⚡[$time] $level/$tag: ';
  }
}
