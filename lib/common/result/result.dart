import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:dcc_toolkit/chopper/base_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

/// Result class to handle success and failure states.
@immutable
sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success(value);

  factory Result.failure(BaseError? exception) => Failure(exception);

  /// Returns the value if [Result] is [Success] or null otherwise.
  T? get getOrNull => switch (this) {
        Success(value: final value) => value,
        _ => null,
      };

  /// Returns the exception if [Result] is [Failure] or null otherwise.
  BaseError? get errorOrNull => switch (this) {
        Failure(error: final error) => error,
        _ => null,
      };

  /// Returns true if [Result] is [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns true if [Result] is [Failure].
  bool get isFailure => this is Failure<T>;

  /// Maps the value of [Result] if it is [Success] or returns the same [Result] otherwise.
  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success(value: final value) => Result.success(transform(value)),
      Failure(error: final error) => Result.failure(error),
    };
  }

  /// Maps the value of the result and returns the error or success [TResult]
  TResult when<TResult extends Object?>({
    required TResult Function(BaseError? error) error,
    required TResult Function(T? response) success,
  }) {
    if (this.isSuccess) {
      return success(getOrNull);
    } else {
      return error(errorOrNull);
    }
  }
}

/// Executes the given API call [fn]. When the call succeeds, [Result.success] is returned with the response.
/// When the call fails the optional [onError] is executed and the exceptions are handled.
/// If there is no [onError] provided, an error of type [BaseError] is returned in [Result.failure].
Future<Result<S>> tryCall<S>(
  FutureOr<S> Function() fn, {
  Future<Result<S>> Function(Exception error)? onError,
}) async {
  try {
    return Result.success(await fn());
  } on Exception catch (e) {
    if (onError != null) {
      return onError(e);
    }
    return switch (e) {
      ChopperHttpException() => Result.failure(
          switch (e.response.statusCode) {
            401 => const AuthenticationFailedError(),
            _ => const ServerError(),
          },
        ),
      ClientException() => Result.failure(const NoInternetError()),
      CheckedFromJsonException() => Result.failure(const ServerError()),
      _ => Result.failure(const UnknownError()),
    };
  }
}

/// Class representing a successful result.
@immutable
final class Success<T> extends Result<T> {
  /// Creates a [Success] with the given [value].
  const Success(this.value);

  /// The value of the [Result].
  final T value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Success<T> && runtimeType == other.runtimeType && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Class representing a failed result.
@immutable
final class Failure<T> extends Result<T> {
  /// Creates a [Failure] with the given [error].
  const Failure(this.error);

  /// The exception of the [Result].
  final BaseError? error;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Failure<T> && runtimeType == other.runtimeType && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}
