import 'package:collection/collection.dart';

/// Insert additional value into iterables.
extension Insert<T> on Iterable<T> {
  /// Insert [value] between each element of the iterable.
  Iterable<T> addBetween(T value) {
    return expandIndexed((int index, T element) sync* {
      yield element;
      if (index < length - 1) yield value;
    });
  }
}
