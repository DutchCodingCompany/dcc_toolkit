import 'package:dcc_toolkit/logger/bolt_logger.dart';
import 'package:dcc_toolkit/logger/charges/debug_console_charge.dart';
import 'package:dcc_toolkit/logger/charges/memory_charge.dart';
import 'package:dcc_toolkit/logger/extensions/stacktrace.dart';
import 'package:dcc_toolkit/logger/extensions/zap_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

void main() {
  tearDown(() => BoltLogger().discharge());

  test('simple example', () {
    BoltLogger.charge([const DebugConsoleCharge()]);

    BoltLogger.zap('zapper message');
    BoltLogger.zap('striker!', level: Level.SEVERE);

    ReferenceTestClass().testMethod();
  });

  test('MemoryCharge', () {
    final memoryCharge = MemoryCharge();
    BoltLogger.charge([memoryCharge]);

    BoltLogger.zap('zapper message');
    BoltLogger.zap('striker!', level: Level.SEVERE);

    ReferenceTestClass().testMethod();

    expect(memoryCharge.items.length, 4);
  });

  test('MemoryCharge + Console', () {
    final memoryCharge = MemoryCharge();
    BoltLogger.charge([
      memoryCharge,
      const DebugConsoleCharge(),
    ]);

    BoltLogger.zap('zapper message');
    BoltLogger.zap('striker!', level: Level.SEVERE);

    ReferenceTestClass().testMethod();

    expect(memoryCharge.items.length, 4);
  });

  test('StackTrace', () {
    BoltLogger.charge([const DebugConsoleCharge()]);
    ReferenceTestClass().testMethod2();
  });

  test('Zap list', () {
    BoltLogger.charge([const DebugConsoleCharge()]);
    BoltLogger.zap(['zap', const FormatException('shock')]);
    expect(() => BoltLogger.zap(['zap', 'strike', 'shock']), throwsAssertionError);
  });
}

class ReferenceTestClass {
  void testMethod() {
    zap('zap message');
    zap('strike!', level: Level.SEVERE);
  }

  void testMethod2() {
    final stackTrace = StackTrace.current;
    zap(stackTrace);
    zap('striked: ${stackTrace.strike}');
    zap(const FormatException('Shock!'));
  }
}
