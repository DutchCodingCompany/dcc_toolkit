import 'dart:ui';

import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';

/// {@macro surface_group}
class SurfaceGroup implements SurfaceGroupInterface<Color> {
  /// {@macro surface_group}
  const SurfaceGroup({
    required this.color,
    required this.onColorContrast,
    required this.onColorContrastDim,
    required this.onColorSubtle,
    required this.onColorSubtleDim,
    required this.containerLowest,
    required this.containerLow,
    required this.container,
    required this.containerHigh,
    required this.containerHighest,
    required this.link,
  });

  @override
  final Color color;

  @override
  final Color onColorContrast;

  @override
  final Color onColorContrastDim;

  @override
  final Color onColorSubtle;

  @override
  final Color onColorSubtleDim;

  @override
  final Color containerLowest;

  @override
  final Color containerLow;

  @override
  final Color container;

  @override
  final Color containerHigh;

  @override
  final Color containerHighest;

  @override
  final Color link;

  @override
  SurfaceGroup lerp(SurfaceGroup? other, double t) {
    if (other == null) return this;

    return SurfaceGroup(
      color: Color.lerp(color, other.color, t)!,
      onColorContrast: Color.lerp(onColorContrast, other.onColorContrast, t)!,
      onColorContrastDim:
          Color.lerp(onColorContrastDim, other.onColorContrastDim, t)!,
      onColorSubtle: Color.lerp(onColorSubtle, other.onColorSubtle, t)!,
      onColorSubtleDim:
          Color.lerp(onColorSubtleDim, other.onColorSubtleDim, t)!,
      containerLowest: Color.lerp(containerLowest, other.containerLowest, t)!,
      containerLow: Color.lerp(containerLow, other.containerLow, t)!,
      container: Color.lerp(container, other.container, t)!,
      containerHigh: Color.lerp(containerHigh, other.containerHigh, t)!,
      containerHighest:
          Color.lerp(containerHighest, other.containerHighest, t)!,
      link: Color.lerp(link, other.link, t)!,
    );
  }
}
