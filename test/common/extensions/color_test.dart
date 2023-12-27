import 'package:dcc_toolkit/common/extensions/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Color extension test', () {
    const color = Color(0xFFFFFFFF);
    final result = color.toColorFilter();

    expect(result, const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn));
  });
}
