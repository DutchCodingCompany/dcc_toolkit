import 'package:dcc_toolkit/style/interface/boekwerk_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:flutter/material.dart';

/// {@template katjas_boekwerk}
/// A [ThemeExtension] that provides a complete typography scale using [Handschrift] styles.
///
/// This class implements [BoekwerkInterface] and integrates with Flutter's theming system,
/// allowing the typography scale to be included in [ThemeData.extensions] and supporting
/// smooth interpolation during theme transitions.
///
/// ## Usage
///
/// ```dart
/// final theme = ThemeData(
///   extensions: [
///     KatjasBoekwerk(
///       displayLarge: Handschrift(fontSize: 57),
///       bodyMedium: Handschrift(fontSize: 14),
///       // ... other styles
///     ),
///   ],
/// );
///
/// // Access in widgets:
/// final boekwerk = Theme.of(context).extension<KatjasBoekwerk>();
/// ```
/// {@endtemplate}
class KatjasBoekwerk extends ThemeExtension<KatjasBoekwerk> implements BoekwerkInterface<Handschrift> {
  /// {@macro katjas_boekwerk}
  KatjasBoekwerk({
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.subtitleLarge,
    this.subtitleMedium,
    this.subtitleSmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
    this.navbar,
  });

  @override
  final Handschrift? displayLarge;
  @override
  final Handschrift? displayMedium;
  @override
  final Handschrift? displaySmall;
  @override
  final Handschrift? subtitleLarge;
  @override
  final Handschrift? subtitleMedium;
  @override
  final Handschrift? subtitleSmall;
  @override
  final Handschrift? headlineLarge;
  @override
  final Handschrift? headlineMedium;
  @override
  final Handschrift? headlineSmall;
  @override
  final Handschrift? titleLarge;
  @override
  final Handschrift? titleMedium;
  @override
  final Handschrift? titleSmall;
  @override
  final Handschrift? bodyLarge;
  @override
  final Handschrift? bodyMedium;
  @override
  final Handschrift? bodySmall;
  @override
  final Handschrift? labelLarge;
  @override
  final Handschrift? labelMedium;
  @override
  final Handschrift? labelSmall;
  @override
  final Handschrift? navbar;

  /// Converts this typography scale to a Flutter [TextTheme].
  ///
  /// The [bodyColor] is applied to body text styles, while [displayColor]
  /// (defaults to [bodyColor]) is applied to display styles. The [decorationColor]
  /// (defaults to [bodyColor]) is used for text decorations.
  ///
  /// Note: [subtitleLarge], [subtitleMedium], [subtitleSmall], and [navbar]
  /// styles are not included in the returned [TextTheme] as they are custom
  /// additions not present in Material Design's typography scale.
  TextTheme asTextTheme({required Color bodyColor, Color? displayColor, Color? decorationColor}) => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  ).apply(displayColor: displayColor ?? bodyColor, bodyColor: bodyColor, decorationColor: decorationColor ?? bodyColor);

  /// Creates a copy of this [KatjasBoekwerk] with the given fields replaced.
  @override
  ThemeExtension<KatjasBoekwerk> copyWith({
    Handschrift? displayLarge,
    Handschrift? displayMedium,
    Handschrift? displaySmall,
    Handschrift? subtitleLarge,
    Handschrift? subtitleMedium,
    Handschrift? subtitleSmall,
    Handschrift? headlineLarge,
    Handschrift? headlineMedium,
    Handschrift? headlineSmall,
    Handschrift? titleLarge,
    Handschrift? titleMedium,
    Handschrift? titleSmall,
    Handschrift? bodyLarge,
    Handschrift? bodyMedium,
    Handschrift? bodySmall,
    Handschrift? labelLarge,
    Handschrift? labelMedium,
    Handschrift? labelSmall,
  }) => KatjasBoekwerk(
    displayLarge: displayLarge ?? this.displayLarge,
    displayMedium: displayMedium ?? this.displayMedium,
    displaySmall: displaySmall ?? this.displaySmall,
    subtitleLarge: subtitleLarge ?? this.subtitleLarge,
    subtitleMedium: subtitleMedium ?? this.subtitleMedium,
    subtitleSmall: subtitleSmall ?? this.subtitleSmall,
    headlineLarge: headlineLarge ?? this.headlineLarge,
    headlineMedium: headlineMedium ?? this.headlineMedium,
    headlineSmall: headlineSmall ?? this.headlineSmall,
    titleLarge: titleLarge ?? this.titleLarge,
    titleMedium: titleMedium ?? this.titleMedium,
    titleSmall: titleSmall ?? this.titleSmall,
    bodyLarge: bodyLarge ?? this.bodyLarge,
    bodyMedium: bodyMedium ?? this.bodyMedium,
    bodySmall: bodySmall ?? this.bodySmall,
    labelLarge: labelLarge ?? this.labelLarge,
    labelMedium: labelMedium ?? this.labelMedium,
    labelSmall: labelSmall ?? this.labelSmall,
  );

  /// Linearly interpolates between this [KatjasBoekwerk] and [other].
  ///
  /// Uses [Handschrift.lerp] to interpolate each text style in the typography scale.
  @override
  ThemeExtension<KatjasBoekwerk> lerp(covariant ThemeExtension<KatjasBoekwerk>? other, double t) {
    if (other is! KatjasBoekwerk) return this;

    return KatjasBoekwerk(
      displayLarge: displayLarge?.lerp(other.displayLarge, t),
      displayMedium: displayMedium?.lerp(other.displayMedium, t),
      displaySmall: displaySmall?.lerp(other.displaySmall, t),
      subtitleLarge: subtitleLarge?.lerp(other.subtitleLarge, t),
      subtitleMedium: subtitleMedium?.lerp(other.subtitleMedium, t),
      subtitleSmall: subtitleSmall?.lerp(other.subtitleSmall, t),
      headlineLarge: headlineLarge?.lerp(other.headlineLarge, t),
      headlineMedium: headlineMedium?.lerp(other.headlineMedium, t),
      headlineSmall: headlineSmall?.lerp(other.headlineSmall, t),
      titleLarge: titleLarge?.lerp(other.titleLarge, t),
      titleMedium: titleMedium?.lerp(other.titleMedium, t),
      titleSmall: titleSmall?.lerp(other.titleSmall, t),
      bodyLarge: bodyLarge?.lerp(other.bodyLarge, t),
      bodyMedium: bodyMedium?.lerp(other.bodyMedium, t),
      bodySmall: bodySmall?.lerp(other.bodySmall, t),
      labelLarge: labelLarge?.lerp(other.labelLarge, t),
      labelMedium: labelMedium?.lerp(other.labelMedium, t),
      labelSmall: labelSmall?.lerp(other.labelSmall, t),
    );
  }
}
