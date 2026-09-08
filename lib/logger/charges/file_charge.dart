import 'dart:async';
import 'dart:io';

import 'package:dcc_toolkit/logger/charges/bolt_charge.dart';
import 'package:dcc_toolkit/logger/zap_event.dart';
import 'package:intl/intl.dart';

/// {@template file_charge}
/// A [BoltCharge] that logs output to a file.
///
/// The [FileCharge] will write logs to a file in the specified [path].
/// Logs are written to the file in batches, this is done when it reaches the [bufferSize] or every [writeDelay].
///
/// {@endtemplate}
class FileCharge implements BoltCharge {
  /// {@macro file_charge}
  FileCharge(this.path, {this.bufferSize = 1000, this.writeDelay = const Duration(seconds: 5)}) {
    _timer = Timer.periodic(writeDelay, (_) => _flush());
  }
  @override
  String get name => 'FileCharge';

  /// The size of the buffer (in lines) before writing to the file.
  final int bufferSize;

  /// The path to the directory where the log files will be written.
  final String path;

  /// The delay between writing to the file.
  final Duration writeDelay;
  final List<ZapEvent> _buffer = [];
  IOSink? _sink;
  String? _sinkFileName;
  Timer? _timer;

  @override
  void logOutput(ZapEvent event) {
    _buffer.add(event);

    if (_buffer.length >= bufferSize) {
      _flush();
    }
  }

  void _flush() {
    if (_buffer.isEmpty) return;

    final sink = _openSink();
    if (sink == null) {
      _buffer.clear();
      return;
    }

    for (final event in _buffer) {
      sink
        ..writeAll(event.lines, '\n')
        ..writeln();
    }
    _buffer.clear();
  }

  /// Opens (or reopens) the sink for today's log file. Returns `null` when the
  /// file cannot be opened, so that logging never crashes the app.
  IOSink? _openSink() {
    final fileName = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}.log';

    if (_sink != null && _sinkFileName == fileName) return _sink;

    unawaited(_sink?.close().catchError((_) {}));
    _sink = null;
    _sinkFileName = null;

    try {
      Directory(path).createSync(recursive: true);
      _sink = File('$path/$fileName').openWrite(mode: FileMode.append);
      _sinkFileName = fileName;
    } on FileSystemException {
      return null;
    }

    return _sink;
  }

  @override
  void discharge() {
    _timer?.cancel();
    _timer = null;
    _flush();
    unawaited(_sink?.close().catchError((_) {}));
    _sink = null;
    _sinkFileName = null;
  }
}
