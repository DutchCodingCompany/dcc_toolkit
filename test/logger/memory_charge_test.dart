import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  test('ZapEvents are added to the items and stream', () async {
    final memoryCharge = MemoryCharge();
    final streamedEvents = <ZapEvent>[];
    memoryCharge.stream.listen(streamedEvents.add);

    expect(memoryCharge.items, isEmpty);

    memoryCharge.logOutput(_produceEvent('test event'));
    await Future<void>.delayed(Duration.zero);

    expect(memoryCharge.items.length, 1);
    expect(streamedEvents.length, 1);

    memoryCharge.discharge();
  });

  test('ZapEvents dont exceed limit', () async {
    final memoryCharge = MemoryCharge(maxItems: 5);
    final streamedEvents = <ZapEvent>[];
    memoryCharge.stream.listen(streamedEvents.add);

    expect(memoryCharge.items, isEmpty);

    for (var i = 0; i < 10; i++) {
      memoryCharge.logOutput(_produceEvent('$i'));
      await Future<void>.delayed(Duration.zero);
    }

    expect(memoryCharge.items.length, 5);
    expect(memoryCharge.items.first.origin.message, '5');
    expect(memoryCharge.items.last.origin.message, '9');
    expect(streamedEvents.length, 10);

    memoryCharge.discharge();
  });
}

ZapEvent _produceEvent(String input) {
  return ZapEvent.fromRecord(LogRecord(Level.INFO, input, 'test'));
}
