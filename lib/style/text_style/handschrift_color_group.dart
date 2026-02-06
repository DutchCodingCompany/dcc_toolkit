import 'package:dcc_toolkit/style/interface/color_group_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';

/// {@macro color_group}
class HandschriftColorGroup implements ColorGroupInterface<Handschrift> {
  /// {@macro color_group}
  const HandschriftColorGroup({required this.color, required this.onColorContrast, this.onColorSubtle});

  @override
  final Handschrift color;

  @override
  final Handschrift onColorContrast;

  @override
  final Handschrift? onColorSubtle;

  @override
  HandschriftColorGroup lerp(HandschriftColorGroup? other, double t) => this;
}
