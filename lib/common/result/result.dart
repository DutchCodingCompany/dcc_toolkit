import 'package:flutter/foundation.dart';

/// Result class to handle success, failure and loading states.
@immutable
sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success(value);

  factory Result.failure(Exception? exception) => Failure(exception);

  factory Result.loading() => Loading<T>();

  /// Returns the value if [Result] is [Success] or null otherwise.
  T? get getOrNull => switch (this) {
        Success(value: final value) => value,
        _ => null,
      };

  /// Returns the exception if [Result] is [Failure] or null otherwise.
  Exception? get exceptionOrNull => switch (this) {
        Failure(exception: final exception) => exception,
        _ => null,
      };

  /// Returns true if [Result] is [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns true if [Result] is [Loading].
  bool get isLoading => this is Loading<T>;

  /// Returns true if [Result] is [Failure].
  bool get isFailure => this is Failure<T>;

  /// Maps the value of [Result] if it is [Success] or returns the same [Result] otherwise.
  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success(value: final value) => Result.success(transform(value)),
      _ => this as Result<R>,
    };
  }

  /// Maps the value of [Result] if it is [Success] or returns the same [Result] otherwise.
  /// This catches any exception thrown by [transform] and returns a [Failure] with the exception.
  Result<R> mapCatch<R>(R Function(T value) transform) {
    return switch (this) {
      Success(value: final value) => () {
          try {
            return Result.success(transform(value));
          } on Exception catch (e) {
            return Failure<R>(e);
          }
        }(),
      _ => this as Result<R>,
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
    return identical(this, other) ||
        other is Success<T> &&
            runtimeType == other.runtimeType &&
            value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Class representing a failed result.
@immutable
final class Failure<T> extends Result<T> {
  /// Creates a [Failure] with the given [exception].
  const Failure(this.exception);

  /// The exception of the [Result].
  final Exception? exception;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Failure<T> &&
            runtimeType == other.runtimeType &&
            other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;
}

/// Class representing a loading result.
@immutable
final class Loading<T> extends Result<T> {
  /// Creates a [Loading].
  const Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Loading<T> && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => 1;
}
