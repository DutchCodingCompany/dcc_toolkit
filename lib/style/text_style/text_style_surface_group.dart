import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:flutter/material.dart';

/// {@macro surface_group}
class TextStyleSurfaceGroup implements SurfaceGroupInterface<TextStyle> {
  /// {@macro surface_group}
  const TextStyleSurfaceGroup({
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
  final TextStyle color;
  @override
  final TextStyle onColorContrast;
  @override
  final TextStyle onColorContrastDim;
  @override
  final TextStyle onColorSubtle;
  @override
  final TextStyle onColorSubtleDim;

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
  final TextStyle link;

  @override
  TextStyleSurfaceGroup lerp(TextStyleSurfaceGroup? other, double t) => this;
}
