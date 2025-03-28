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
  const TextStyleDecorator(this._textStyle, this._kleurplaat);

  final TextStyle _textStyle;
  final KatjasKleurplaat _kleurplaat;

  @override
  ColorGroupInterface<TextStyle> get content => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.content.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.content.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.content.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get contentFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.contentFill.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.contentFill.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.contentFill.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get error => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.error.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.error.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.error.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get errorFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.errorFill.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.errorFill.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.errorFill.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get primary => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.primary.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.primary.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.primary.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get primaryFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.primaryFill.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.primaryFill.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.primaryFill.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get secondary => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.secondary?.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.secondary?.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.secondary?.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get secondaryFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.secondaryFill?.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.secondaryFill?.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.secondaryFill?.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get tertiary => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.tertiary?.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.tertiary?.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.tertiary?.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get tertiaryFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.tertiaryFill?.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.tertiaryFill?.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.tertiaryFill?.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get success => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.success.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.success.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.success.onColorSubtle),
  );

  @override
  ColorGroupInterface<TextStyle> get successFill => TextStyleColorGroup(
    color: _textStyle.copyWith(color: _kleurplaat.successFill.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.successFill.onColorContrast),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.successFill.onColorSubtle),
  );

  @override
  SurfaceGroupInterface<TextStyle> get surface => TextStyleSurfaceGroup(
    color: _textStyle.copyWith(color: _kleurplaat.surface.color),
    onColorContrast: _textStyle.copyWith(color: _kleurplaat.surface.onColorContrast),
    onColorContrastDim: _textStyle.copyWith(color: _kleurplaat.surface.onColorContrastDim),
    onColorSubtle: _textStyle.copyWith(color: _kleurplaat.surface.onColorSubtle),
    onColorSubtleDim: _textStyle.copyWith(color: _kleurplaat.surface.onColorSubtleDim),
    containerLowest: _textStyle.copyWith(color: _kleurplaat.surface.containerLowest),
    containerLow: _textStyle.copyWith(color: _kleurplaat.surface.containerLow),
    container: _textStyle.copyWith(color: _kleurplaat.surface.container),
    containerHigh: _textStyle.copyWith(color: _kleurplaat.surface.containerHigh),
    containerHighest: _textStyle.copyWith(color: _kleurplaat.surface.containerHighest),
    link: _textStyle.copyWith(color: _kleurplaat.surface.link),
  );

  @override
  SurfaceGroupInterface<TextStyle>? get surfaceInverse {
    if (_kleurplaat.surfaceInverse == null) return null;
    return TextStyleSurfaceGroup(
      color: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.color),
      onColorContrast: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.onColorContrast),
      onColorContrastDim: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.onColorContrastDim),
      onColorSubtle: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.onColorSubtle),
      onColorSubtleDim: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.onColorSubtleDim),
      containerLowest: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.containerLowest),
      containerLow: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.containerLow),
      container: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.container),
      containerHigh: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.containerHigh),
      containerHighest: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.containerHighest),
      link: _textStyle.copyWith(color: _kleurplaat.surfaceInverse!.link),
    );
  }
}
