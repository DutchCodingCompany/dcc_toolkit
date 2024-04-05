import 'dart:async';

import 'package:dcc_toolkit/logger/charges/bolt_charge.dart';
import 'package:dcc_toolkit/logger/ui/bolt_logger_view.dart';
import 'package:dcc_toolkit/logger/zap_event.dart';

/// {@template memory_charge}
/// A [BoltCharge] that stores logs in memory.
/// This will be used for viewing logs in the app. With the [BoltLoggerView] widget.
///
/// By default, the [maxItems] is set to 1000. This is the amount of logs that will be stored in memory.
///
/// {@endtemplate}
class MemoryCharge implements BoltCharge {
  /// {@macro memory_charge}
  MemoryCharge({this.maxItems = 1000});

  @override
   String get name => 'MemoryCharge';

  /// The maximum amount of logs to store in memory.
  final int maxItems;
  final List<ZapEvent> _items = [];

  final StreamController<ZapEvent> _controller = StreamController.broadcast();

  /// The stream of [ZapEvent]s.
  Stream<ZapEvent> get stream => _controller.stream;

  /// The list of [ZapEvent]s currently stored in memory.
  List<ZapEvent> get items => _items.toList(growable: false);

  @override
  void logOutput(ZapEvent event) {
    if (_items.length >= maxItems) {
      _items.removeAt(0);
    }
    _items.add(event);
    _controller.add(event);
  }

  @override
  void discharge() {
   _controller.close();
   _items.clear();
  }
}
