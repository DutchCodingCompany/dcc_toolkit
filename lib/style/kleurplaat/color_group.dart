import 'dart:ui';

import 'package:dcc_toolkit/style/interface/color_group_interface.dart';

/// {@macro color_group}
class ColorGroup implements ColorGroupInterface<Color> {
  /// {@macro color_group}
  const ColorGroup({
    required this.color,
    required this.onColor,
    this.onColorSubtle,
  });

  @override
  final Color color;

  @override
  final Color onColor;

  @override
  final Color? onColorSubtle;

  @override
  ColorGroup lerp(ColorGroup? other, double t) {
    if (other is! ColorGroup) {
      return this;
    }

    return ColorGroup(
      color: Color.lerp(color, other.color, t) ?? color,
      onColor: Color.lerp(onColor, other.onColor, t) ?? onColor,
      onColorSubtle: onColorSubtle == null || other.onColorSubtle == null
          ? null
          : Color.lerp(onColorSubtle, other.onColorSubtle, t),
    );
  }
}
