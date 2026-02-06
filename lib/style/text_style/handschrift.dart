import 'package:flutter/material.dart';

/// An extended [TextStyle] that supports additional style variants for bold and link text.
///
/// [Handschrift] (Dutch for "handwriting") extends Flutter's [TextStyle] to provide
/// built-in support for common text style variations used in rich text rendering.
/// This allows a single style definition to carry information about how bold and
/// linked text should be rendered.
///
/// This class is particularly useful when you need consistent bold or link styling
/// that can be easily accessed via the [bold] and [link] getters, which merge the
/// respective variant styles with the base style.
///
/// ## Example
///
/// ```dart
/// final style = Handschrift(
///   fontSize: 16,
///   color: Colors.black,
///   boldStyle: TextStyle(fontWeight: FontWeight.bold),
///   linkStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
/// );
///
/// // Use the bold variant
/// Text('Bold text', style: style.bold);
///
/// // Use the link variant
/// Text('Click here', style: style.link);
/// ```
///
/// ## Creating from an existing TextStyle
///
/// Use [Handschrift.fromTextStyle] to convert an existing [TextStyle]:
///
/// ```dart
/// final baseStyle = TextStyle(fontSize: 14);
/// final handschrift = Handschrift.fromTextStyle(
///   baseStyle,
///   boldStyle: TextStyle(fontWeight: FontWeight.w700),
/// );
/// ```
///
/// ## Animation Support
///
/// [Handschrift] supports smooth interpolation via the [lerp] method,
/// which interpolates all properties including the bold and link variants.
class Handschrift extends TextStyle {
  /// Creates a [Handschrift] with the given properties.
  ///
  /// All parameters from [TextStyle] are supported, plus:
  /// - [boldStyle]: Optional style to merge when accessing [bold]
  /// - [linkStyle]: Optional style to merge when accessing [link]
  const Handschrift({
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

  /// Creates a [Handschrift] from an existing [TextStyle].
  ///
  /// This factory constructor copies all properties from [style] and adds
  /// the optional [boldStyle] and [linkStyle] variants.
  ///
  // ignore: comment_references
  /// Note: The [package] property from the original style is not preserved
  /// as it cannot be accessed from an existing [TextStyle].
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

  /// The style to merge when [bold] is accessed.
  final TextStyle? _boldStyle;

  /// The style to merge when [link] is accessed.
  final TextStyle? _linkStyle;

  /// Returns this style merged with [_boldStyle].
  ///
  /// Use this getter to apply bold styling to text while preserving
  /// all other properties of this [Handschrift].
  TextStyle get bold => merge(_boldStyle);

  /// Returns this style merged with [_linkStyle].
  ///
  /// Use this getter to apply link styling (typically color and underline)
  /// to text while preserving all other properties of this [Handschrift].
  TextStyle get link => merge(_linkStyle);

  /// Linearly interpolates between this [Handschrift] and [other].
  ///
  /// The [t] parameter represents the position on the timeline, where 0.0
  /// means this style, 1.0 means [other], and values in between represent
  /// a blend of both styles.
  ///
  /// This method interpolates all [TextStyle] properties as well as the
  /// [_boldStyle] and [_linkStyle] variants.
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

  /// Creates a copy of this [Handschrift] with the given fields replaced.
  ///
  /// This override extends [TextStyle.copyWith] to also support copying
  /// the [boldStyle] and [linkStyle] variants.
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
