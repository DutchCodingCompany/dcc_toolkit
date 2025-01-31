import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:flutter/material.dart';

/// {@macro surface_group}
class TextStyleSurfaceGroup implements SurfaceGroupInterface<TextStyle> {
  /// {@macro surface_group}
  const TextStyleSurfaceGroup({
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
  final TextStyle color;
  @override
  final TextStyle onColorContrastPlus;
  @override
  final TextStyle onColorContrastMinus;
  @override
  final TextStyle onColorSubtlePlus;
  @override
  final TextStyle onColorSubtleMinus;

  @override
  final TextStyle containerLowest;
  @override
  final TextStyle containerLow;
  @override
  final TextStyle container;
  @override
  final TextStyle containerHigh;
  @override
  final TextStyle containerHighest;

  @override
  TextStyleSurfaceGroup lerp(TextStyleSurfaceGroup? other, double t) => this;
}
