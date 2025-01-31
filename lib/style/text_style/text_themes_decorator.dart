import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';
import 'package:dcc_toolkit/style/text_style/text_style_decorator.dart';
import 'package:flutter/material.dart';

/// {@template text_themes_decorator}
// Is imported via `package:flutter/material.dart`
// ignore: comment_references
/// Decorates a [TextThemes] with [KatjasKleurplaat] colors.
/// {@endtemplate}
class TextThemesDecorator {
  /// {@macro text_themes_decorator}
  const TextThemesDecorator(
    this._textTheme,
    this._katjasKleurplaat,
  );

  final TextTheme _textTheme;
  final KatjasKleurplaat _katjasKleurplaat;

  /// See [TextTheme.displayLarge].
  TextStyleDecorator? get displayLarge => _textTheme.displayLarge != null
      ? TextStyleDecorator(
          _textTheme.displayLarge!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.displayMedium].
  TextStyleDecorator? get displayMedium => _textTheme.displayMedium != null
      ? TextStyleDecorator(
          _textTheme.displayMedium!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.displaySmall].
  TextStyleDecorator? get displaySmall => _textTheme.displaySmall != null
      ? TextStyleDecorator(
          _textTheme.displaySmall!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.headlineLarge].
  TextStyleDecorator? get headlineLarge => _textTheme.headlineLarge != null
      ? TextStyleDecorator(
          _textTheme.headlineLarge!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.headlineMedium].
  TextStyleDecorator? get headlineMedium => _textTheme.headlineMedium != null
      ? TextStyleDecorator(
          _textTheme.headlineMedium!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.headlineSmall].
  TextStyleDecorator? get headlineSmall => _textTheme.headlineSmall != null
      ? TextStyleDecorator(
          _textTheme.headlineSmall!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.titleLarge].
  TextStyleDecorator? get titleLarge => _textTheme.titleLarge != null
      ? TextStyleDecorator(
          _textTheme.titleLarge!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.titleMedium].
  TextStyleDecorator? get titleMedium => _textTheme.titleMedium != null
      ? TextStyleDecorator(
          _textTheme.titleMedium!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.titleSmall].
  TextStyleDecorator? get titleSmall => _textTheme.titleSmall != null
      ? TextStyleDecorator(
          _textTheme.titleSmall!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.bodyLarge].
  TextStyleDecorator? get bodyLarge => _textTheme.bodyLarge != null
      ? TextStyleDecorator(
          _textTheme.bodyLarge!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.bodyMedium].
  TextStyleDecorator? get bodyMedium => _textTheme.bodyMedium != null
      ? TextStyleDecorator(
          _textTheme.bodyMedium!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.bodySmall].
  TextStyleDecorator? get bodySmall => _textTheme.bodySmall != null
      ? TextStyleDecorator(
          _textTheme.bodySmall!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.labelLarge].
  TextStyleDecorator? get labelLarge => _textTheme.labelLarge != null
      ? TextStyleDecorator(
          _textTheme.labelLarge!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.labelMedium].
  TextStyleDecorator? get labelMedium => _textTheme.labelMedium != null
      ? TextStyleDecorator(
          _textTheme.labelMedium!,
          _katjasKleurplaat,
        )
      : null;

  /// See [TextTheme.labelSmall].
  TextStyleDecorator? get labelSmall => _textTheme.labelSmall != null
      ? TextStyleDecorator(
          _textTheme.labelSmall!,
          _katjasKleurplaat,
        )
      : null;
}
