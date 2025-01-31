import 'package:dcc_toolkit/style/interface/color_group_interface.dart';
import 'package:flutter/material.dart';

/// {@macro color_group}
class TextStyleColorGroup implements ColorGroupInterface<TextStyle> {
  /// {@macro color_group}
  const TextStyleColorGroup({
    required this.color,
    required this.onColor,
    this.onColorSubtle,
  });

  @override
  final TextStyle color;

  @override
  final TextStyle onColor;

  @override
  final TextStyle? onColorSubtle;

  @override
  TextStyleColorGroup lerp(TextStyleColorGroup? other, double t) => this;
}
