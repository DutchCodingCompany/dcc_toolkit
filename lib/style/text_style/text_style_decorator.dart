import 'package:dcc_toolkit/style/interface/color_group_interface.dart';
import 'package:dcc_toolkit/style/interface/kleurplaat_interface.dart';
import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';
import 'package:dcc_toolkit/style/text_style/text_style_color_group.dart';
import 'package:dcc_toolkit/style/text_style/text_style_surface_group.dart';
import 'package:flutter/material.dart';

/// {@template text_style_decorator}
/// Decorates a [TextStyle] with [KatjasKleurplaat] colors.
/// {@endtemplate}
class TextStyleDecorator implements KleurplaatInterface<TextStyle> {
  /// {@macro text_style_decorator}
  const TextStyleDecorator(
    this._textStyle,
    this._kleurplaat,
  );

  final TextStyle _textStyle;
  final KatjasKleurplaat _kleurplaat;

  @override
  ColorGroupInterface<TextStyle> get content => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.content.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.content.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.content.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get contentFill => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.contentFill.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.contentFill.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.contentFill.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get error => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.error.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.error.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.error.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get errorFill => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.errorFill.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.errorFill.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.errorFill.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get primary => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.primary.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.primary.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.primary.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get primaryFill => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.primaryFill.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.primaryFill.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.primaryFill.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get success => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.success.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.success.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.success.onColorSubtle,
        ),
      );

  @override
  ColorGroupInterface<TextStyle> get successFill => TextStyleColorGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.successFill.color,
        ),
        onColor: _textStyle.copyWith(
          color: _kleurplaat.successFill.onColor,
        ),
        onColorSubtle: _textStyle.copyWith(
          color: _kleurplaat.successFill.onColorSubtle,
        ),
      );

  @override
  SurfaceGroupInterface<TextStyle> get surface => TextStyleSurfaceGroup(
        color: _textStyle.copyWith(
          color: _kleurplaat.surface.color,
        ),
        onColorContrastPlus: _textStyle.copyWith(
          color: _kleurplaat.surface.onColorContrastPlus,
        ),
        onColorContrastMinus: _textStyle.copyWith(
          color: _kleurplaat.surface.onColorContrastMinus,
        ),
        onColorSubtlePlus: _textStyle.copyWith(
          color: _kleurplaat.surface.onColorSubtlePlus,
        ),
        onColorSubtleMinus: _textStyle.copyWith(
          color: _kleurplaat.surface.onColorSubtleMinus,
        ),
        containerLowest: _textStyle.copyWith(
          color: _kleurplaat.surface.containerLowest,
        ),
        containerLow: _textStyle.copyWith(
          color: _kleurplaat.surface.containerLow,
        ),
        container: _textStyle.copyWith(
          color: _kleurplaat.surface.container,
        ),
        containerHigh: _textStyle.copyWith(
          color: _kleurplaat.surface.containerHigh,
        ),
        containerHighest: _textStyle.copyWith(
          color: _kleurplaat.surface.containerHighest,
        ),
      );
}
