import 'package:dcc_toolkit/common/extensions/iterable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  parameterizedTest('addBetween tests', [
    [
      <int>[],
      <int>[],
    ],
    [
      [1],
      [1],
    ],
    [
      [1, 2],
      [1, 0, 2],
    ],
    [
      [1, 2, 3],
      [1, 0, 2, 0, 3],
    ],
  ], (List<int> initial, List<int> expected) {
    expect(initial.addBetween(0), expected);
  });
}
