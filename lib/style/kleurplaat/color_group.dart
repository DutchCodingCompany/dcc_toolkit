import 'dart:ui';

import 'package:dcc_toolkit/style/interface/color_group_interface.dart';

/// {@macro color_group}
class const ColorGroup({
  @override required final Color color,
  @override required final Color onColorContrast,
  @override final Color? onColorSubtle,
}) implements ColorGroupInterface<Color> {
  /// {@macro color_group}
  this;

  @override
  ColorGroup lerp(ColorGroup? other, double t) {
    if (other is! ColorGroup) {
      return this;
    }

    return ColorGroup(
      color: Color.lerp(color, other.color, t) ?? color,
      onColorContrast: Color.lerp(onColorContrast, other.onColorContrast, t) ?? onColorContrast,
      onColorSubtle: onColorSubtle == null || other.onColorSubtle == null
          ? null
          : Color.lerp(onColorSubtle, other.onColorSubtle, t),
    );
  }
}
