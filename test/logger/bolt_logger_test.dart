// Mocktail doesn't work properly with tear-offs
//ignore_for_file: unnecessary_lambdas
import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parameterized_test/parameterized_test.dart';

class _MockCharge extends Mock implements BoltCharge {}

void main() {
  tearDown(() => BoltLogger.discharge());

  group('charge tests', () {
    test('BoltLogger without a charge only redirect log event to root Logger',
        () {
      final records = <LogRecord>[];
      Logger.root.level = Level.ALL;
      final sub = Logger.root.onRecord.listen(records.add);

      BoltLogger.zap('zap1');
      BoltLogger.zap('zap2');
      BoltLogger.shock('shock1');
      BoltLogger.shock('shock2');

      expect(records.length, 4);
      expect(records[0].message, 'zap1');
      expect(records[1].message, 'zap2');
      expect(records[2].message, 'shock1');
      expect(records[3].message, 'shock2');

      sub.cancel();
    });

    test('BoltLogger can only contain 1 charge of the same type', () {
      final memoryCharge1 = MemoryCharge(maxItems: 1);
      final memoryCharge2 = MemoryCharge(maxItems: 2);
      BoltLogger.charge([memoryCharge1, memoryCharge2]);

      BoltLogger.zap('zap');

      expect(
        BoltLogger.getCharge('MemoryCharge'),
        isA<MemoryCharge>().having(
          (e) => e.maxItems,
          'maxItems',
          1,
        ),
      );
      expect(memoryCharge1.items.length, 1);
      expect(memoryCharge2.items.length, 0);
    });

    test('BoltLogger discharge, discharges all charges', () {
      final charge = _MockCharge();
      final charge2 = _MockCharge();
      when(() => charge.name).thenReturn('MockCharge');
      when(() => charge2.name).thenReturn('MockCharge2');
      when(() => charge.discharge()).thenReturn(null);
      when(() => charge2.discharge()).thenReturn(null);

      BoltLogger.charge([charge, charge2]);
      BoltLogger.discharge();

      verify(() => charge.discharge()).called(1);
      verify(() => charge2.discharge()).called(1);
    });
  });

  group('zap test', () {
    late MemoryCharge memoryCharge;
    setUp(() {
      memoryCharge = MemoryCharge();
      BoltLogger.charge([memoryCharge]);
    });

    parameterizedGroup1('BoltLogger/extension function tests', [true, false],
        (bool useBoltLogger) {
      test('zap/shock sends a message via a ZapEvent to a charge', () {
        if (useBoltLogger) {
          BoltLogger.zap('zap');
          BoltLogger.shock('shock');
        } else {
          TestReferenceClass().zapExtension('zap');
          TestReferenceClass().shockExtension('shock');
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.message, 'zap');
        expect(
          memoryCharge.items[0].origin.loggerName,
          useBoltLogger ? 'BoltLogger' : 'TestReferenceClass',
        );
        expect(memoryCharge.items[1].origin.message, 'shock');
        expect(
          memoryCharge.items[1].origin.loggerName,
          useBoltLogger ? 'BoltLogger' : 'TestReferenceClass',
        );
        expect(memoryCharge.items[1].origin.level, Level.SEVERE);
      });

      test('zap/shock sends a tag via a ZapEvent to a charge', () {
        if (useBoltLogger) {
          BoltLogger.zap('zap', tag: 'tag1');
          BoltLogger.shock('shock', tag: 'tag2');
        } else {
          TestReferenceClass().zapExtension('zap', tag: 'tag1');
          TestReferenceClass().shockExtension('shock', tag: 'tag2');
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.loggerName, 'tag1');
        expect(memoryCharge.items[1].origin.loggerName, 'tag2');
        expect(memoryCharge.items[1].origin.level, Level.SEVERE);
      });

      parameterizedTest1(
          'zap/shock sends a LogLevel via a ZapEvent to a Charge', [
        Level.ALL,
        Level.CONFIG,
        Level.FINE,
        Level.FINER,
        Level.FINEST,
        Level.INFO,
        Level.OFF,
        Level.SEVERE,
        Level.SHOUT,
        Level.WARNING,
      ], (Level level) {
        if (useBoltLogger) {
          BoltLogger.zap('zap', level: level);
          BoltLogger.zap('shock', level: level);
        } else {
          TestReferenceClass().zapExtension('zap', level: level);
          TestReferenceClass().shockExtension('shock', level: level);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.level, level);
        expect(memoryCharge.items[1].origin.level, level);
      });

      test('zap/shock sends Exception via a ZapEvent to a Charge', () {
        final exception = Exception('exception');
        if (useBoltLogger) {
          BoltLogger.zap(exception);
          BoltLogger.shock(exception);
        } else {
          TestReferenceClass().zapExtension(exception);
          TestReferenceClass().shockExtension(exception);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.error, exception);
        expect(memoryCharge.items[1].origin.error, exception);
      });

      test('zap/shock sends Error via a ZapEvent to a Charge', () {
        final error = Error();
        if (useBoltLogger) {
          BoltLogger.zap(error);
          BoltLogger.shock(error);
        } else {
          TestReferenceClass().zapExtension(error);
          TestReferenceClass().shockExtension(error);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.error, error);
        expect(memoryCharge.items[1].origin.error, error);
      });

      test('zap/shock sends StackTrace via a ZapEvent to a Charge', () {
        final stackTrace = StackTrace.current;
        if (useBoltLogger) {
          BoltLogger.zap(stackTrace);
          BoltLogger.shock(stackTrace);
        } else {
          TestReferenceClass().zapExtension(stackTrace);
          TestReferenceClass().shockExtension(stackTrace);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.stackTrace, stackTrace);
        expect(memoryCharge.items[1].origin.stackTrace, stackTrace);
      });

      test('zap/shock sends Function via a ZapEvent to a Charge', () {
        String func() => 'function';
        if (useBoltLogger) {
          BoltLogger.zap(func);
          BoltLogger.shock(func);
        } else {
          TestReferenceClass().zapExtension(func);
          TestReferenceClass().shockExtension(func);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.message, 'function');
        expect(memoryCharge.items[1].origin.message, 'function');
      });

      test('zap/shock sends Object via a ZapEvent to a Charge', () {
        if (useBoltLogger) {
          BoltLogger.zap(1);
          BoltLogger.shock(1);
        } else {
          TestReferenceClass().zapExtension(1);
          TestReferenceClass().shockExtension(1);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.message, '1');
        expect(memoryCharge.items[1].origin.message, '1');
      });

      test('zap/shock sends a List via a ZapEvent to a Charge', () {
        final exception = Exception('exception');
        final stackTrace = StackTrace.current;
        if (useBoltLogger) {
          BoltLogger.zap(['zap', exception, stackTrace]);
          BoltLogger.shock(['shock', exception, stackTrace]);
        } else {
          TestReferenceClass().zapExtension(['zap', exception, stackTrace]);
          TestReferenceClass().shockExtension(['shock', exception, stackTrace]);
        }

        expect(memoryCharge.items.length, 2);
        expect(memoryCharge.items[0].origin.message, 'zap');
        expect(memoryCharge.items[0].origin.error, exception);
        expect(memoryCharge.items[0].origin.stackTrace, stackTrace);
        expect(memoryCharge.items[1].origin.message, 'shock');
        expect(memoryCharge.items[1].origin.error, exception);
        expect(memoryCharge.items[1].origin.stackTrace, stackTrace);
      });

      test(
          'zap/shock sends a List with more than 3 elements via a ZapEvent to a Charge',
          () {
        final exception = Exception('exception');
        final stackTrace = StackTrace.current;
        final error = Error();
        if (useBoltLogger) {
          expect(
            () => BoltLogger.zap(['zap', exception, stackTrace, error]),
            throwsAssertionError,
          );
          expect(
            () => BoltLogger.shock(['shock', exception, stackTrace, error]),
            throwsAssertionError,
          );
        } else {
          expect(
            () => TestReferenceClass()
                .zapExtension(['zap', exception, stackTrace, error]),
            throwsAssertionError,
          );
          expect(
            () => TestReferenceClass()
                .shockExtension(['shock', exception, stackTrace, error]),
            throwsAssertionError,
          );
        }
      });
    });
  });
}

class TestReferenceClass {
  void zapExtension(Object? message, {String? tag, Level level = Level.INFO}) =>
      zap(message, tag: tag, level: level);

  void shockExtension(
    Object? message, {
    String? tag,
    Level level = Level.SEVERE,
  }) =>
      shock(message, tag: tag, level: level);
}
