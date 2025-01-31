import 'package:dcc_toolkit/style/interface/kleurplaat_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/color_group.dart';
import 'package:dcc_toolkit/style/kleurplaat/surface_group.dart';
import 'package:flutter/material.dart';

/// {@macro kleurplaat}
class KatjasKleurplaat extends ThemeExtension<KatjasKleurplaat>
    implements KleurplaatInterface<Color> {
  /// {@macro kleurplaat}
  const KatjasKleurplaat({
    required this.primary,
    required this.primaryFill,
    required this.content,
    required this.contentFill,
    required this.error,
    required this.errorFill,
    required this.success,
    required this.successFill,
    required this.surface,
    required this.surfaceInverse,
  });

  @override
  final ColorGroup primary;

  @override
  final ColorGroup primaryFill;

  @override
  final ColorGroup content;

  @override
  final ColorGroup contentFill;

  @override
  final ColorGroup error;

  @override
  final ColorGroup errorFill;

  @override
  final ColorGroup success;

  @override
  final ColorGroup successFill;

  @override
  final SurfaceGroup surface;

  @override
  final SurfaceGroup? surfaceInverse;

  @override
  ThemeExtension<KatjasKleurplaat> copyWith({
    ColorGroup? primary,
    ColorGroup? primaryFill,
    ColorGroup? content,
    ColorGroup? contentFill,
    ColorGroup? error,
    ColorGroup? errorFill,
    ColorGroup? success,
    ColorGroup? successFill,
    SurfaceGroup? surface,
    SurfaceGroup? surfaceInverse,
  }) =>
      KatjasKleurplaat(
        primary: primary ?? this.primary,
        primaryFill: primaryFill ?? this.primaryFill,
        content: content ?? this.content,
        contentFill: contentFill ?? this.contentFill,
        error: error ?? this.error,
        errorFill: errorFill ?? this.errorFill,
        success: success ?? this.success,
        successFill: successFill ?? this.successFill,
        surface: surface ?? this.surface,
        surfaceInverse: surfaceInverse ?? this.surfaceInverse,
      );

  @override
  KatjasKleurplaat lerp(KatjasKleurplaat? other, double t) {
    if (other is! KatjasKleurplaat) return this;

    return KatjasKleurplaat(
      primary: primary.lerp(other.primary, t),
      primaryFill: primaryFill.lerp(other.primaryFill, t),
      content: content.lerp(other.content, t),
      contentFill: contentFill.lerp(other.contentFill, t),
      error: error.lerp(other.error, t),
      errorFill: errorFill.lerp(other.errorFill, t),
      success: success.lerp(other.success, t),
      successFill: successFill.lerp(other.successFill, t),
      surface: surface.lerp(other.surface, t),
      surfaceInverse: surfaceInverse?.lerp(other.surfaceInverse, t),
    );
  }

  /// Converts the [KatjasKleurplaat] to a [ColorScheme].
  ColorScheme toColorScheme({Brightness brightness = Brightness.light}) =>
      ColorScheme(
        brightness: brightness,
        primary: primary.color,
        primaryContainer: primary.color,
        onPrimary: primary.onColorContrast,
        onPrimaryContainer: primary.onColorContrast,
        secondary: content.color,
        secondaryContainer: content.color,
        onSecondary: content.onColorContrast,
        onSecondaryContainer: content.onColorContrast,
        tertiary: error.color,
        onTertiary: error.onColorContrast,
        error: error.color,
        onError: error.onColorContrast,
        surface: surface.color,
        onSurface: surface.onColorContrast,
      );
}
