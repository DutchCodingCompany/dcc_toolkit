import 'package:dcc_toolkit/style/interface/boekwerk_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';
import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:dcc_toolkit/style/text_style/handschrift_decorator.dart';
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';

/// {@template boekwerk_decorator}
/// Decorates a [KatjasBoekwerk] with [KatjasKleurplaat] colors.
///
/// This class wraps a [KatjasBoekwerk] typography scale and applies color
/// information from a [KatjasKleurplaat] color palette, producing
/// [HandschriftDecorator] instances that combine both style and color.
///
/// Each getter returns a [HandschriftDecorator] that wraps the corresponding
/// [Handschrift] from the underlying [KatjasBoekwerk], or `null` if the
/// source style is not defined.
/// {@endtemplate}
class BoekwerkDecorator implements BoekwerkInterface<HandschriftDecorator> {
  /// {@macro boekwerk_decorator}
  const BoekwerkDecorator(this._katjasBoekwerk, this._katjasKleurplaat);

  /// The underlying typography scale to decorate.
  final KatjasBoekwerk _katjasBoekwerk;

  /// The color palette to apply to the typography.
  final KatjasKleurplaat _katjasKleurplaat;

  @override
  HandschriftDecorator? get displayLarge =>
      _katjasBoekwerk.displayLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.displayLarge!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get displayMedium =>
      _katjasBoekwerk.displayMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.displayMedium!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get displaySmall =>
      _katjasBoekwerk.displaySmall != null
          ? HandschriftDecorator(_katjasBoekwerk.displaySmall!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get subtitleLarge =>
      _katjasBoekwerk.subtitleLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleLarge!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get subtitleMedium =>
      _katjasBoekwerk.subtitleMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleMedium!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get subtitleSmall =>
      _katjasBoekwerk.subtitleSmall != null
          ? HandschriftDecorator(_katjasBoekwerk.subtitleSmall!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get headlineLarge =>
      _katjasBoekwerk.headlineLarge != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineLarge!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get headlineMedium =>
      _katjasBoekwerk.headlineMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineMedium!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get headlineSmall =>
      _katjasBoekwerk.headlineSmall != null
          ? HandschriftDecorator(_katjasBoekwerk.headlineSmall!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get titleLarge =>
      _katjasBoekwerk.titleLarge != null ? HandschriftDecorator(_katjasBoekwerk.titleLarge!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get titleMedium =>
      _katjasBoekwerk.titleMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.titleMedium!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get titleSmall =>
      _katjasBoekwerk.titleSmall != null ? HandschriftDecorator(_katjasBoekwerk.titleSmall!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get bodyLarge =>
      _katjasBoekwerk.bodyLarge != null ? HandschriftDecorator(_katjasBoekwerk.bodyLarge!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get bodyMedium =>
      _katjasBoekwerk.bodyMedium != null ? HandschriftDecorator(_katjasBoekwerk.bodyMedium!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get bodySmall =>
      _katjasBoekwerk.bodySmall != null ? HandschriftDecorator(_katjasBoekwerk.bodySmall!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get labelLarge =>
      _katjasBoekwerk.labelLarge != null ? HandschriftDecorator(_katjasBoekwerk.labelLarge!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get labelMedium =>
      _katjasBoekwerk.labelMedium != null
          ? HandschriftDecorator(_katjasBoekwerk.labelMedium!, _katjasKleurplaat)
          : null;

  @override
  HandschriftDecorator? get labelSmall =>
      _katjasBoekwerk.labelSmall != null ? HandschriftDecorator(_katjasBoekwerk.labelSmall!, _katjasKleurplaat) : null;

  @override
  HandschriftDecorator? get navbar =>
      _katjasBoekwerk.navbar != null ? HandschriftDecorator(_katjasBoekwerk.navbar!, _katjasKleurplaat) : null;
}
