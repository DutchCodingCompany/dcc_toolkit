import 'package:dcc_toolkit/debouncer/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Debouncer tests', () {
    late Debouncer debouncer;

    tearDown(() {
      debouncer.dispose();
    });

    group('constructor tests', () {
      test('should use default delay of 400ms when no delay is provided', () {
        debouncer = Debouncer();
        expect(debouncer.delay, equals(const Duration(milliseconds: 400)));
      });

      test('should use custom delay when provided', () {
        const customDelay = Duration(milliseconds: 200);
        debouncer = Debouncer(delay: customDelay);
        expect(debouncer.delay, equals(customDelay));
      });
    });

    group('run method tests', () {
      test('should execute action after default delay', () async {
        debouncer = Debouncer();
        var actionExecuted = false;

        debouncer.run(() {
          actionExecuted = true;
        });

        // Action should not be executed immediately
        expect(actionExecuted, isFalse);

        // Wait for the default delay to pass
        await Future<void>.delayed(const Duration(milliseconds: 450));

        // Action should now be executed
        expect(actionExecuted, isTrue);
      });

      test('should execute action after custom delay', () async {
        const customDelay = Duration(milliseconds: 100);
        debouncer = Debouncer(delay: customDelay);
        var actionExecuted = false;

        debouncer.run(() {
          actionExecuted = true;
        });

        // Action should not be executed immediately
        expect(actionExecuted, isFalse);

        // Wait less than the delay
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(actionExecuted, isFalse);

        // Wait for the custom delay to pass
        await Future<void>.delayed(const Duration(milliseconds: 60));

        // Action should now be executed
        expect(actionExecuted, isTrue);
      });

      test('should cancel previous timer when run is called multiple times', () async {
        debouncer = Debouncer(delay: const Duration(milliseconds: 100));
        var executionCount = 0;

        // First call
        debouncer.run(() {
          executionCount++;
        });

        // Wait less than delay
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Second call should cancel the first
        debouncer.run(() {
          executionCount++;
        });

        // Wait for the second delay to complete
        await Future<void>.delayed(const Duration(milliseconds: 120));

        // Only the second action should have executed
        expect(executionCount, equals(1));
      });

      test('should handle multiple rapid calls correctly', () async {
        debouncer = Debouncer(delay: const Duration(milliseconds: 100));
        var executionCount = 0;

        // Make multiple rapid calls
        for (var i = 0; i < 5; i++) {
          debouncer.run(() {
            executionCount++;
          });
          await Future<void>.delayed(const Duration(milliseconds: 10));
        }

        // Wait for delay to pass
        await Future<void>.delayed(const Duration(milliseconds: 120));

        // Only the last action should have executed
        expect(executionCount, equals(1));
      });

      test('should execute different actions correctly', () async {
        debouncer = Debouncer(delay: const Duration(milliseconds: 50));
        final results = <String>[];

        debouncer.run(() {
          results.add('first');
        });

        await Future<void>.delayed(const Duration(milliseconds: 25));

        debouncer.run(() {
          results.add('second');
        });

        await Future<void>.delayed(const Duration(milliseconds: 70));

        expect(results, equals(['second']));
      });
    });

    group('edge cases tests', () {
      test('should handle zero delay', () async {
        debouncer = Debouncer(delay: Duration.zero);
        var actionExecuted = false;

        debouncer.run(() {
          actionExecuted = true;
        });

        // Even with zero delay, action should execute asynchronously
        expect(actionExecuted, isFalse);

        await Future<void>.delayed(const Duration(milliseconds: 1));

        expect(actionExecuted, isTrue);
      });

      test('should handle very long delay', () async {
        debouncer = Debouncer(delay: const Duration(seconds: 1));
        var actionExecuted = false;

        debouncer.run(() {
          actionExecuted = true;
        });

        await Future<void>.delayed(const Duration(milliseconds: 100));
        expect(actionExecuted, isFalse);

        debouncer.dispose();
      });
    });

    group('timing precision tests', () {
      test('should not execute action before delay', () async {
        debouncer = Debouncer(delay: const Duration(milliseconds: 100));
        var actionExecuted = false;

        debouncer.run(() {
          actionExecuted = true;
        });

        // Check at various points before delay
        await Future<void>.delayed(const Duration(milliseconds: 10));
        expect(actionExecuted, isFalse);

        await Future<void>.delayed(const Duration(milliseconds: 40));
        expect(actionExecuted, isFalse);

        await Future<void>.delayed(const Duration(milliseconds: 40));
        expect(actionExecuted, isFalse);

        // Wait for completion
        await Future<void>.delayed(const Duration(milliseconds: 20));
        expect(actionExecuted, isTrue);
      });
    });
  });
}
