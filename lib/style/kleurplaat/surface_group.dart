import 'dart:ui';

import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';

/// {@macro surface_group}
class SurfaceGroup implements SurfaceGroupInterface<Color> {
  /// {@macro surface_group}
  const SurfaceGroup({
    required this.color,
    required this.onColorContrastPlus,
    required this.onColorContrastMinus,
    required this.onColorSubtlePlus,
    required this.onColorSubtleMinus,
    required this.containerLowest,
    required this.containerLow,
    required this.container,
    required this.containerHigh,
    required this.containerHighest,
  });

  @override
  final Color color;

  @override
  final Color onColorContrastPlus;

  @override
  final Color onColorContrastMinus;

  @override
  final Color onColorSubtlePlus;

  @override
  final Color onColorSubtleMinus;

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
  SurfaceGroup lerp(SurfaceGroup? other, double t) {
    if (other == null) return this;

    return SurfaceGroup(
      color: Color.lerp(color, other.color, t)!,
      onColorContrastPlus:
          Color.lerp(onColorContrastPlus, other.onColorContrastPlus, t)!,
      onColorContrastMinus:
          Color.lerp(onColorContrastMinus, other.onColorContrastMinus, t)!,
      onColorSubtlePlus:
          Color.lerp(onColorSubtlePlus, other.onColorSubtlePlus, t)!,
      onColorSubtleMinus:
          Color.lerp(onColorSubtleMinus, other.onColorSubtleMinus, t)!,
      containerLowest: Color.lerp(containerLowest, other.containerLowest, t)!,
      containerLow: Color.lerp(containerLow, other.containerLow, t)!,
      container: Color.lerp(container, other.container, t)!,
      containerHigh: Color.lerp(containerHigh, other.containerHigh, t)!,
      containerHighest:
          Color.lerp(containerHighest, other.containerHighest, t)!,
    );
  }
}
