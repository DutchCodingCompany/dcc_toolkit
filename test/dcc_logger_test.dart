//ignore_for_file: deprecated_member_use_from_same_package
import 'package:dcc_toolkit/common/dcc_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  group('uninitialised tests', () {
    test('throws assertion error when logger is not initialised', () {
      expect(
        () => DCCLogger.info('test message'),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => DCCLogger.severe('test message'),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('DCCLogger', () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
      when(() => mockLogger.info(any())).thenReturn(null);
      when(() => mockLogger.severe(any())).thenReturn(null);

      DCCLogger.initialise(null, null, mockLogger);
    });

    test('logs info message correctly', () {
      DCCLogger.info('test message', tag: 'test');

      verify(() => mockLogger.info(any())).called(1);
    });

    test('logs severe message correctly', () {
      DCCLogger.severe('test message', tag: 'test');

      verify(() => mockLogger.severe(any())).called(1);
    });
  });
}
