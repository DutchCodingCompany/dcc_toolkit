import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';

/// {@template color_group}
/// Group of colors defined for [KatjasKleurplaat].
/// {@endtemplate}
abstract interface class ColorGroupInterface<T> {
  /// {@template color}
  /// The color on the background.
  /// {@endtemplate}
  T get color;

  /// {@template on_color}
  /// The color on the foreground. Usually on top of the [color].
  /// {@endtemplate}
  T get onColor;

  /// {@template on_color_subtle}
  /// The color on the foreground, but more subtle. Usually on top of the [color].
  /// {@endtemplate}
  T? get onColorSubtle;

  /// Linearly interpolate with another object.
  ColorGroupInterface<T> lerp(
      covariant ColorGroupInterface<T>? other, double t);
}
