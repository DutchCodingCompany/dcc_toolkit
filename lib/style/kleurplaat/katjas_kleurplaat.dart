import 'package:dcc_toolkit/style/interface/kleurplaat_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/color_group.dart';
import 'package:dcc_toolkit/style/kleurplaat/surface_group.dart';
import 'package:material_ui/material_ui.dart';

/// {@macro kleurplaat}
class const KatjasKleurplaat({
  @override required final ColorGroup primary,
  @override required final ColorGroup primaryFill,
  @override required final ColorGroup content,
  @override required final ColorGroup contentFill,
  @override required final ColorGroup error,
  @override required final ColorGroup errorFill,
  @override required final ColorGroup success,
  @override required final ColorGroup successFill,
  @override required final SurfaceGroup surface,
  @override required final SurfaceGroup? surfaceInverse,
  @override final ColorGroup? secondary,
  @override final ColorGroup? secondaryFill,
  @override final ColorGroup? tertiary,
  @override final ColorGroup? tertiaryFill,
  @override final ColorGroup? accent,
  @override final ColorGroup? accentFill,
}) extends ThemeExtension<KatjasKleurplaat> implements KleurplaatInterface<Color> {
  /// {@macro kleurplaat}
  this;

  @override
  ThemeExtension<KatjasKleurplaat> copyWith({
    ColorGroup? primary,
    ColorGroup? primaryFill,
    ColorGroup? secondary,
    ColorGroup? secondaryFill,
    ColorGroup? tertiary,
    ColorGroup? tertiaryFill,
    ColorGroup? accent,
    ColorGroup? accentFill,
    ColorGroup? content,
    ColorGroup? contentFill,
    ColorGroup? error,
    ColorGroup? errorFill,
    ColorGroup? success,
    ColorGroup? successFill,
    SurfaceGroup? surface,
    SurfaceGroup? surfaceInverse,
  }) => KatjasKleurplaat(
    primary: primary ?? this.primary,
    primaryFill: primaryFill ?? this.primaryFill,
    secondary: secondary ?? this.secondary,
    secondaryFill: secondaryFill ?? this.secondaryFill,
    tertiary: tertiary ?? this.tertiary,
    tertiaryFill: tertiaryFill ?? this.tertiaryFill,
    accent: accent ?? this.accent,
    accentFill: accentFill ?? this.accentFill,
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
      secondary: secondary?.lerp(other.secondary, t),
      secondaryFill: secondaryFill?.lerp(other.secondaryFill, t),
      tertiary: tertiary?.lerp(other.tertiary, t),
      tertiaryFill: tertiaryFill?.lerp(other.tertiaryFill, t),
      accent: accent?.lerp(other.accent, t),
      accentFill: accentFill?.lerp(other.accentFill, t),
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
  ColorScheme toColorScheme({Brightness brightness = Brightness.light}) => ColorScheme(
    brightness: brightness,
    primary: primary.color,
    primaryContainer: primary.color,
    onPrimary: primary.onColorContrast,
    onPrimaryContainer: primary.onColorContrast,
    secondary: content.color,
    secondaryContainer: content.color,
    secondaryFixed: secondary?.color,
    secondaryFixedDim: secondaryFill?.color,
    tertiaryFixed: tertiary?.color,
    tertiaryFixedDim: tertiaryFill?.color,
    onTertiaryFixed: accent?.color,
    onTertiaryFixedVariant: accentFill?.color,
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
