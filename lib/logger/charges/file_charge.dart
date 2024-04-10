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
  FileCharge(this.path,
      {this.bufferSize = 1000, this.writeDelay = const Duration(seconds: 5),}) {
    final fileName = '${DateFormat('yyyy-MM-dd').format(DateTime.now())}.log';
    _file = File('$path/$fileName');

    Timer.periodic(writeDelay, (_) => _flush());
  }
  @override
  String get name => 'FileCharge';

  /// The size of the buffer (in lines) before writing to the file.
  final int bufferSize;

  /// The path to the directory where the log files will be written.
  final String path;

  /// The delay between writing to the file.
  final Duration writeDelay;
  File? _file;
  final List<ZapEvent> _buffer = [];
  IOSink? _sink;
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

    _sink ??= _file?.openWrite(mode: FileMode.append);

    for (final event in _buffer) {
      _sink?.writeAll(event.lines, '\n');
      _sink?.writeln();
    }
    _buffer.clear();
  }

  @override
  void discharge() {
    _timer?.cancel();
    _timer = null;
    _flush();
    _sink?.close();
    _sink = null;
  }
}
