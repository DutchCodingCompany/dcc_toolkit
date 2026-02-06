import 'package:dcc_toolkit/style/interface/boekwerk_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';
import 'package:dcc_toolkit/style/text_style/handschrift_decorator.dart';
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';

/// {@template text_themes_decorator}
// Is imported via `package:flutter/material.dart`
// ignore: comment_references
/// Decorates a [KatjasBoekwerk] with [KatjasKleurplaat] colors.
/// {@endtemplate}
class BoekwerkDecorator implements BoekwerkInterface<HandschriftDecorator> {
  /// {@macro text_themes_decorator}
  const BoekwerkDecorator(this._katjasBoekwerk, this._katjasKleurplaat);

  final KatjasBoekwerk _katjasBoekwerk;
  final KatjasKleurplaat _katjasKleurplaat;

  HandschriftDecorator? get displayLarge =>
      _katjasBoekwerk.displayLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.displayLarge!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get displayMedium =>
      _katjasBoekwerk.displayMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.displayMedium!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get displaySmall =>
      _katjasBoekwerk.displaySmall != null
          ? HandschriftDecorator(_katjasBoekwerk.displaySmall!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get subtitleLarge =>
      _katjasBoekwerk.subtitleLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleLarge!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get subtitleMedium =>
      _katjasBoekwerk.subtitleMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleMedium!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get subtitleSmall =>
      _katjasBoekwerk.subtitleSmall != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleSmall!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get headlineLarge =>
      _katjasBoekwerk.headlineLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineLarge!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get headlineMedium =>
      _katjasBoekwerk.headlineMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineMedium!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get headlineSmall =>
      _katjasBoekwerk.headlineSmall != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineSmall!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get titleLarge =>
      _katjasBoekwerk.titleLarge != null ? HandschriftDecorator(_katjasBoekwerk.titleLarge!, _katjasKleurplaat) : null;

  HandschriftDecorator? get titleMedium =>
      _katjasBoekwerk.titleMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.titleMedium!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get titleSmall =>
      _katjasBoekwerk.titleSmall != null ? HandschriftDecorator(_katjasBoekwerk.titleSmall!, _katjasKleurplaat) : null;

  HandschriftDecorator? get bodyLarge =>
      _katjasBoekwerk.bodyLarge != null ? HandschriftDecorator(_katjasBoekwerk.bodyLarge!, _katjasKleurplaat) : null;

  HandschriftDecorator? get bodyMedium =>
      _katjasBoekwerk.bodyMedium != null ? HandschriftDecorator(_katjasBoekwerk.bodyMedium!, _katjasKleurplaat) : null;

  HandschriftDecorator? get bodySmall =>
      _katjasBoekwerk.bodySmall != null ? HandschriftDecorator(_katjasBoekwerk.bodySmall!, _katjasKleurplaat) : null;

  HandschriftDecorator? get labelLarge =>
      _katjasBoekwerk.labelLarge != null ? HandschriftDecorator(_katjasBoekwerk.labelLarge!, _katjasKleurplaat) : null;

  HandschriftDecorator? get labelMedium =>
      _katjasBoekwerk.labelMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.labelMedium!, _katjasKleurplaat)
          : null;

  HandschriftDecorator? get labelSmall =>
      _katjasBoekwerk.labelSmall != null ? HandschriftDecorator(_katjasBoekwerk.labelSmall!, _katjasKleurplaat) : null;

  HandschriftDecorator? get navbar =>
      _katjasBoekwerk.navbar != null ? HandschriftDecorator(_katjasBoekwerk.navbar!, _katjasKleurplaat) : null;
}
