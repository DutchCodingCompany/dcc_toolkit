import 'package:chopper/chopper.dart' as c;
import 'package:dcc_toolkit/chopper/base_error.dart';
import 'package:dcc_toolkit/common/result/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  test('returns the correct value', () async {
    final result1 = await tryCall(() async => 1);
    final result2 = await tryCall(() => 2);
    final result3 = await tryCall(() {
      return 3;
    });
    final result4 = await tryCall(() async {
      return 4;
    });
    final result5 = await tryCall(getResult5);
    final result6 = await tryCall(getResult6);

    expect(result1, Result.success(1));
    expect(result2, Result.success(2));
    expect(result3, Result.success(3));
    expect(result4, Result.success(4));
    expect(result5, Result.success(5));
    expect(result6, Result.success(6));
  });

  test('returns the error value', () async {
    final result1 = await tryCall(() async => throw Exception(1));
    final result2 = await tryCall(() => throw Exception(2));
    final result3 = await tryCall(() {
      return throw Exception(3);
    });
    final result4 = await tryCall(() async {
      return throw Exception(4);
    });
    final result5 = await tryCall(getError5);
    final result6 = await tryCall(getError6);

    expect(result1, Result<Never>.failure(const UnknownError()));
    expect(result2, Result<Never>.failure(const UnknownError()));
    expect(result3, Result<Never>.failure(const UnknownError()));
    expect(result4, Result<Never>.failure(const UnknownError()));
    expect(result5, Result<int>.failure(const UnknownError()));
    expect(result6, Result<int>.failure(const UnknownError()));
  });

  test('returns the error with later await value', () async {
    final result1 = tryCall(() async => throw Exception(1));
    final result2 = tryCall(() => throw Exception(2));
    final result3 = tryCall(() {
      return throw Exception(3);
    });
    final result4 = tryCall(() async {
      return throw Exception(4);
    });
    final result5 = tryCall(getError5);
    final result6 = tryCall(getError6);

    expect(await result1, Result<Never>.failure(const UnknownError()));
    expect(await result2, Result<Never>.failure(const UnknownError()));
    expect(await result3, Result<Never>.failure(const UnknownError()));
    expect(await result4, Result<Never>.failure(const UnknownError()));
    expect(await result5, Result<int>.failure(const UnknownError()));
    expect(await result6, Result<int>.failure(const UnknownError()));
  });

  parameterizedTest('Different exceptions result in different errors', [
    [Exception('woepsie'), const UnknownError()],
    [const FormatException('woepsie'), const UnknownError()],
    [c.ChopperHttpException(c.Response(http.Response('woepsie', 401), 'woepsie')), const AuthenticationFailedError()],
    [c.ChopperHttpException(c.Response(http.Response('woepsie', 500), 'woepsie')), const ServerError()],
    [ClientException('woepsie'), const NoInternetError()],
    [CheckedFromJsonException({}, null, 'woepsie', null), const ServerError()],
  ], (Exception exception, BaseError expectedError) async {
    final result = await tryCall(() async => throw exception);
    expect(result, Result<Never>.failure(expectedError));
  });
}

int getResult5() {
  return 5;
}

Future<int> getResult6() async {
  return 6;
}

int getError5() {
  return throw Exception(5);
}

Future<int> getError6() async {
  return throw Exception(6);
}
