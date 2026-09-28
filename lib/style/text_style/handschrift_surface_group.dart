import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';

/// {@macro surface_group}
class const HandschriftSurfaceGroup({
  @override required final Handschrift color,
  @override required final Handschrift onColorContrast,
  @override required final Handschrift onColorContrastDim,
  @override required final Handschrift onColorSubtle,
  @override required final Handschrift onColorSubtleDim,
  @override required final Handschrift containerLowest,
  @override required final Handschrift containerLow,
  @override required final Handschrift container,
  @override required final Handschrift containerHigh,
  @override required final Handschrift containerHighest,
  @override required final Handschrift link,
  @override final Handschrift? onColorError,
  @override final Handschrift? onColorSuccess,
  @override final Handschrift? onColorPrimary,
  @override final Handschrift? onColorPrimaryVariant,
}) implements SurfaceGroupInterface<Handschrift> {
  /// {@macro surface_group}
  this;

  @override
  HandschriftSurfaceGroup lerp(HandschriftSurfaceGroup? other, double t) => this;
}
