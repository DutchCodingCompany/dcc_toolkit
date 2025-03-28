import 'dart:ui';

import 'package:dcc_toolkit/chopper/color_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  parameterizedTest(
    'converts color to json value',
    [
      [const Color(0xFF000000), '#ff000000'],
      [const Color(0xFFFF0000), '#ffff0000'],
      [const Color(0xFFFFFF00), '#ffffff00'],
      [const Color(0xFFFFFFFF), '#ffffffff'],
      [const Color(0xF1F1F1F1), '#f1f1f1f1'],
    ],
    (Color color, String expected) {
      final result = const ColorConverter().toJson(color);

      expect(result, expected);
    },
  );

  parameterizedTest(
    'converts json value to color',
    [
      [const Color(0xFF000000), '#ff000000'],
      [const Color(0xFFFF0000), '#ffff0000'],
      [const Color(0xFFFFFF00), '#ffffff00'],
      [const Color(0xFFFFFFFF), '#ffffffff'],
      [const Color(0xF1F1F1F1), '#f1f1f1f1'],
      [const Color(0xFFFFFFFF), '#ffffff'],
    ],
    (Color expected, String json) {
      final result = const ColorConverter().fromJson(json);

      expect(result, expected);
    },
  );
}
