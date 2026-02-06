import 'package:flutter/material.dart';

class Handschrift extends TextStyle {
  Handschrift({
    super.inherit,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamily,
    super.fontFamilyFallback,
    super.package,
    super.overflow,
    TextStyle? boldStyle,
    TextStyle? linkStyle,
  }) : _boldStyle = boldStyle,
       _linkStyle = linkStyle;

  factory Handschrift.fromTextStyle(TextStyle style, {TextStyle? boldStyle, TextStyle? linkStyle}) => Handschrift(
    inherit: style.inherit,
    color: style.color,
    backgroundColor: style.backgroundColor,
    fontSize: style.fontSize,
    fontWeight: style.fontWeight,
    fontStyle: style.fontStyle,
    letterSpacing: style.letterSpacing,
    wordSpacing: style.wordSpacing,
    textBaseline: style.textBaseline,
    height: style.height,
    leadingDistribution: style.leadingDistribution,
    locale: style.locale,
    foreground: style.foreground,
    background: style.background,
    shadows: style.shadows,
    fontFeatures: style.fontFeatures,
    fontVariations: style.fontVariations,
    decoration: style.decoration,
    decorationColor: style.decorationColor,
    decorationStyle: style.decorationStyle,
    decorationThickness: style.decorationThickness,
    debugLabel: style.debugLabel,
    fontFamily: style.fontFamily,
    fontFamilyFallback: style.fontFamilyFallback,
    overflow: style.overflow,
    boldStyle: boldStyle,
    linkStyle: linkStyle,
  );

  final TextStyle? _boldStyle;
  final TextStyle? _linkStyle;

  TextStyle get bold => merge(_boldStyle);

  TextStyle get link => merge(_linkStyle);

  Handschrift lerp(Handschrift? other, double t) {
    if (identical(this, other)) return this;

    final lerped = TextStyle.lerp(this, other, t);
    final boldLerped = TextStyle.lerp(_boldStyle, other?._boldStyle, t);
    final linkLerped = TextStyle.lerp(_linkStyle, other?._linkStyle, t);

    if (lerped != null) {
      return Handschrift.fromTextStyle(lerped, boldStyle: boldLerped, linkStyle: linkLerped);
    } else {
      return this;
    }
  }

  @override
  Handschrift copyWith({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
    TextStyle? boldStyle,
    TextStyle? linkStyle,
  }) => Handschrift(
    inherit: inherit ?? this.inherit,
    color: color ?? this.color,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    fontSize: fontSize ?? this.fontSize,
    fontWeight: fontWeight ?? this.fontWeight,
    fontStyle: fontStyle ?? this.fontStyle,
    letterSpacing: letterSpacing ?? this.letterSpacing,
    wordSpacing: wordSpacing ?? this.wordSpacing,
    textBaseline: textBaseline ?? this.textBaseline,
    height: height ?? this.height,
    leadingDistribution: leadingDistribution ?? this.leadingDistribution,
    locale: locale ?? this.locale,
    foreground: foreground ?? this.foreground,
    background: background ?? this.background,
    shadows: shadows ?? this.shadows,
    fontFeatures: fontFeatures ?? this.fontFeatures,
    fontVariations: fontVariations ?? this.fontVariations,
    decoration: decoration ?? this.decoration,
    decorationColor: decorationColor ?? this.decorationColor,
    decorationStyle: decorationStyle ?? this.decorationStyle,
    decorationThickness: decorationThickness ?? this.decorationThickness,
    debugLabel: debugLabel ?? this.debugLabel,
    fontFamily: fontFamily ?? this.fontFamily,
    fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
    package: package,
    overflow: overflow ?? this.overflow,
    boldStyle: boldStyle ?? _boldStyle,
    linkStyle: linkStyle ?? _linkStyle,
  );
}
