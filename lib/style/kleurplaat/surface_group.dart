import 'dart:ui';

import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';

/// {@macro surface_group}
class const SurfaceGroup({
  @override required final Color color,
  @override required final Color onColorContrast,
  @override required final Color onColorContrastDim,
  @override required final Color onColorSubtle,
  @override required final Color onColorSubtleDim,
  @override required final Color containerLowest,
  @override required final Color containerLow,
  @override required final Color container,
  @override required final Color containerHigh,
  @override required final Color containerHighest,
  @override required final Color link,
  @override final Color? onColorError,
  @override final Color? onColorSuccess,
  @override final Color? onColorPrimary,
  @override final Color? onColorPrimaryVariant,
}) implements SurfaceGroupInterface<Color> {
  /// {@macro surface_group}
  this;

  @override
  SurfaceGroup lerp(SurfaceGroup? other, double t) {
    if (other == null) return this;

    return SurfaceGroup(
      color: Color.lerp(color, other.color, t)!,
      onColorContrast: Color.lerp(onColorContrast, other.onColorContrast, t)!,
      onColorContrastDim: Color.lerp(onColorContrastDim, other.onColorContrastDim, t)!,
      onColorSubtle: Color.lerp(onColorSubtle, other.onColorSubtle, t)!,
      onColorSubtleDim: Color.lerp(onColorSubtleDim, other.onColorSubtleDim, t)!,
      containerLowest: Color.lerp(containerLowest, other.containerLowest, t)!,
      containerLow: Color.lerp(containerLow, other.containerLow, t)!,
      container: Color.lerp(container, other.container, t)!,
      containerHigh: Color.lerp(containerHigh, other.containerHigh, t)!,
      containerHighest: Color.lerp(containerHighest, other.containerHighest, t)!,
      link: Color.lerp(link, other.link, t)!,
      onColorError: Color.lerp(onColorError, other.onColorError, t),
      onColorSuccess: Color.lerp(onColorSuccess, other.onColorSuccess, t),
      onColorPrimary: Color.lerp(onColorPrimary, other.onColorPrimary, t),
      onColorPrimaryVariant: Color.lerp(onColorPrimaryVariant, other.onColorPrimaryVariant, t),
    );
  }
}
