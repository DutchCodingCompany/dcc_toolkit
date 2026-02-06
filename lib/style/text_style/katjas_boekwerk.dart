import 'package:dcc_toolkit/style/interface/boekwerk_interface.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:flutter/material.dart';

class KatjasBoekwerk extends ThemeExtension<KatjasBoekwerk> implements BoekwerkInterface<Handschrift> {
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

  final Handschrift? displayLarge;
  final Handschrift? displayMedium;
  final Handschrift? displaySmall;
  final Handschrift? subtitleLarge;
  final Handschrift? subtitleMedium;
  final Handschrift? subtitleSmall;
  final Handschrift? headlineLarge;
  final Handschrift? headlineMedium;
  final Handschrift? headlineSmall;
  final Handschrift? titleLarge;
  final Handschrift? titleMedium;
  final Handschrift? titleSmall;
  final Handschrift? bodyLarge;
  final Handschrift? bodyMedium;
  final Handschrift? bodySmall;
  final Handschrift? labelLarge;
  final Handschrift? labelMedium;
  final Handschrift? labelSmall;
  final Handschrift? navbar;

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
