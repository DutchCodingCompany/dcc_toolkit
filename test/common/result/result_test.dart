import 'package:dcc_toolkit/chopper/base_error.dart';
import 'package:dcc_toolkit/common/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  const testExceptionResult = Failure<int>(ServerError());
  parameterizedTest(
    'comparing 2 results should return true if equal',
    [
      [const Success<int>(1), const Success<int>(1), true],
      [const Success<int>(1), const Success<int>(2), false],
      [const Success<int>(1), const Failure<int>(ServerError()), false],
      [testExceptionResult, testExceptionResult, true],
    ],
    (Result<int> result1, Result<int> result2, bool expected) {
      final actual = result1 == result2;
      expect(actual, expected);
    },
  );

  test('getOrNull returns value for Success', () {
    final result = Result.success(1);
    expect(result.getOrNull, 1);
  });

  test('getOrNull returns null for Failure', () {
    final result = Result<int>.failure(const ServerError());
    expect(result.getOrNull, null);
  });

  test('exceptionOrNull returns exception for Failure', () {
    const exception = ServerError();
    final result = Result<int>.failure(exception);
    expect(result.errorOrNull, exception);
  });

  test('exceptionOrNull returns null for Success', () {
    final result = Result<int>.success(1);
    expect(result.errorOrNull, null);
  });

  test('isSuccess returns true for Success', () {
    final result = Result<int>.success(1);
    expect(result.isSuccess, true);
  });

  test('isSuccess returns false for Failure', () {
    final result = Result<int>.failure(const ServerError());
    expect(result.isSuccess, false);
  });

  test('isFailure returns true for Failure', () {
    final result = Result<int>.failure(const ServerError());
    expect(result.isFailure, true);
  });

  test('isFailure returns false for Success', () {
    final result = Result<int>.success(1);
    expect(result.isFailure, false);
  });

  test('map transforms value for Success', () {
    final result = Result<int>.success(1);
    final mapped = result.map((value) => value + 1);
    expect(mapped.getOrNull, 2);
  });

  test('map does not transform value for Failure', () {
    final result = Result<int>.failure(const ServerError());
    final mapped = result.map((value) => value + 1);
    expect(mapped.getOrNull, null);
  });
}
