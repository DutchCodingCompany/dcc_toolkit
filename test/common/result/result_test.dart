import 'package:dcc_toolkit/common/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  final testExceptionResult = Failure<int>(Exception('test'));
  parameterizedTest('comparing 2 results should return true if equal', [
    [const Success<int>(1), const Success<int>(1), true],
    [const Success<int>(1), const Success<int>(2), false],
    [const Success<int>(1), const Loading<int>(), false],
    [const Success<int>(1), Failure<int>(Exception('test')), false],
    [const Loading<int>(), Failure<int>(Exception('test')), false],
    [const Loading<int>(), const Loading<int>(), true],
    [Failure<int>(Exception('test')), Failure<int>(Exception('test')), false],
    [testExceptionResult, testExceptionResult, true],
  ], (Result<int> result1, Result<int> result2, bool expected) {
    final actual = result1 == result2;
    expect(actual, expected);
  });

  test('getOrNull returns value for Success', () {
    final result = Result.success(1);
    expect(result.getOrNull, 1);
  });

  test('getOrNull returns null for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    expect(result.getOrNull, null);
  });

  test('getOrNull returns null for Loading', () {
    final result = Result<int>.loading();
    expect(result.getOrNull, null);
  });

  test('exceptionOrNull returns exception for Failure', () {
    final exception = Exception('test');
    final result = Result<int>.failure(exception);
    expect(result.exceptionOrNull, exception);
  });

  test('exceptionOrNull returns null for Success', () {
    final result = Result<int>.success(1);
    expect(result.exceptionOrNull, null);
  });

  test('exceptionOrNull returns null for Loading', () {
    final result = Result<int>.loading();
    expect(result.exceptionOrNull, null);
  });

  test('isSuccess returns true for Success', () {
    final result = Result<int>.success(1);
    expect(result.isSuccess, true);
  });

  test('isSuccess returns false for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    expect(result.isSuccess, false);
  });

  test('isSuccess returns false for Loading', () {
    final result = Result<int>.loading();
    expect(result.isSuccess, false);
  });

  test('isLoading returns true for Loading', () {
    final result = Result<int>.loading();
    expect(result.isLoading, true);
  });

  test('isLoading returns false for Success', () {
    final result = Result<int>.success(1);
    expect(result.isLoading, false);
  });

  test('isLoading returns false for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    expect(result.isLoading, false);
  });

  test('isFailure returns true for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    expect(result.isFailure, true);
  });

  test('isFailure returns false for Success', () {
    final result = Result<int>.success(1);
    expect(result.isFailure, false);
  });

  test('isFailure returns false for Loading', () {
    final result = Result<int>.loading();
    expect(result.isFailure, false);
  });

  test('map transforms value for Success', () {
    final result = Result<int>.success(1);
    final mapped = result.map((value) => value + 1);
    expect(mapped.getOrNull, 2);
  });

  test('map does not transform value for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    final mapped = result.map((value) => value + 1);
    expect(mapped.getOrNull, null);
  });

  test('map does not transform value for Loading', () {
    final result = Result<int>.loading();
    final mapped = result.map((value) => value + 1);
    expect(mapped.getOrNull, null);
  });

  test('mapCatch transforms value for Success', () {
    final result = Result<int>.success(1);
    final mapped = result.mapCatch((value) => value + 1);
    expect(mapped.getOrNull, 2);
  });

  test('mapCatch does not transform value for Failure', () {
    final result = Result<int>.failure(Exception('test'));
    final mapped = result.mapCatch((value) => value + 1);
    expect(mapped.getOrNull, null);
  });

  test('mapCatch does not transform value for Loading', () {
    final result = Result<int>.loading();
    final mapped = result.mapCatch((value) => value + 1);
    expect(mapped.getOrNull, null);
  });

  test('mapCatch catches exception and returns Failure', () {
    final result = Result<int>.success(1);
    final mapped = result.mapCatch((value) => throw Exception('test'));
    expect(mapped.isFailure, true);
  });
}
