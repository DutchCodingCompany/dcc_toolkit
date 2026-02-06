import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';

/// {@macro surface_group}
class HandschriftSurfaceGroup implements SurfaceGroupInterface<Handschrift> {
  /// {@macro surface_group}
  const HandschriftSurfaceGroup({
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
  final Handschrift color;
  @override
  final Handschrift onColorContrast;
  @override
  final Handschrift onColorContrastDim;
  @override
  final Handschrift onColorSubtle;
  @override
  final Handschrift onColorSubtleDim;

  @override
  final Handschrift containerLowest;
  @override
  final Handschrift containerLow;
  @override
  final Handschrift container;
  @override
  final Handschrift containerHigh;
  @override
  final Handschrift containerHighest;
  @override
  final Handschrift link;

  @override
  HandschriftSurfaceGroup lerp(HandschriftSurfaceGroup? other, double t) => this;
}
