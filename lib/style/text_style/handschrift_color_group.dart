import 'package:dcc_toolkit/style/interface/color_group_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';

/// {@macro color_group}
class const HandschriftColorGroup({
  @override required final Handschrift color,
  @override required final Handschrift onColorContrast,
  @override final Handschrift? onColorSubtle,
}) implements ColorGroupInterface<Handschrift> {
  /// {@macro color_group}
  this;

  @override
  HandschriftColorGroup lerp(HandschriftColorGroup? other, double t) => this;
}
