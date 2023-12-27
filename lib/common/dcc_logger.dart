import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

/// A logger that can be used to log messages.
class DCCLogger {
  static Logger? _logger;
  static final DateFormat _formatter = DateFormat(DateFormat.HOUR24_MINUTE);

  /// Initialise the logger. This needs to be called before using the logger.
  /// Using this is done in the main.dart file.
  static void initialise([
    String? name,
    String? tag,
    Logger? logger,
  ]) {
    _logger =
        logger ?? Logger('${name ?? 'DCC'}${tag != null ? ' ($tag)' : ''}');
    final rootLogger = Logger.root;
    rootLogger.onRecord.listen((event) {
      if (kDebugMode) {
        _prettyPrinter(event);
      }
    });
  }

  static void _prettyPrinter(LogRecord record) {
    final error = record.error;
    final stacktrace = record.stackTrace;
    final message = record.object is DCCLogRecord
        ? record.object.toString()
        : record.message;

    debugPrint(_formatLogPrint(record, message));
    if (error != null)
      debugPrint(_formatLogPrint(record, '${error.runtimeType}: $error'));
    if (stacktrace != null) {
      final lines =
          stacktrace.toString().split('\n').where((e) => e.isNotEmpty);
      for (final line in lines) {
        debugPrint(_formatLogPrint(record, line));
      }
    }
  }

  static String _formatLogPrint(LogRecord record, String message) {
    final logMessage =
        '[${_formatter.format(record.time)}] [${record.level.name}] ${record.loggerName}: $message';
    return record.level == Level.SEVERE
        ? _addWarningColor(logMessage)
        : logMessage;
  }

  static String _addWarningColor(String message) {
    return '⚠️$message';
  }

  /// Log an info message
  /// This will be included in the sentry breadcrumbs.
  /// Example:
  /// ```dart
  /// DCCLogger.info('test bericht', tag: 'test');
  /// ```
  /// prints: [[13:46]] [[INFO]] DCC: <test> test bericht
  static void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    assert(_logger != null, 'initialise DCCLogger first');
    _logger?.info(DCCLogRecord(message, tag), error, stackTrace);
  }

  /// Log an severe message.
  /// This will also be sent to sentry.
  /// Example:
  /// ```dart
  /// DCCLogger.severe('test bericht', tag: 'test');
  /// ```
  /// prints: [[13:46]] [[SEVERE]] DCC: <test> test bericht
  static void severe(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    assert(_logger != null, 'initialise DCCLogger first');
    _logger?.severe(DCCLogRecord(message, tag), error, stackTrace);
  }
}

/// A log entry representation used to propagate information to the logger.
class DCCLogRecord {
  /// Creates a new log record.
  const DCCLogRecord(this.message, this.tag);

  /// The message to be logged.
  final String message;

  /// The tag to be logged.
  final String? tag;

  @override
  String toString() => '${tag != null ? '<$tag> ' : ''}$message';
}
