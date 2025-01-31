import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';

/// {@template surface_group}
/// Group of colors defined for surfaces in [KatjasKleurplaat].
/// {@endtemplate}
abstract interface class SurfaceGroupInterface<T> {
  /// {@template color}
  /// The color of the surface.
  /// {@endtemplate}
  T get color;

  /// {@template onColorContrastPlus}
  /// The color on the surface with a higher contrast.
  /// {@endtemplate}
  T get onColorContrastPlus;

  /// {@template onColorContrastMinus}
  /// The color on the surface with a lower contrast.
  /// {@endtemplate}
  T get onColorContrastMinus;

  /// {@template onColorSubtlePlus}
  /// The color on the surface with a higher contrast, but more subtle.
  /// {@endtemplate}
  T get onColorSubtlePlus;

  /// {@template onColorSubtleMinus}
  /// The color on the surface with a lower contrast, but more subtle.
  /// {@endtemplate}
  T get onColorSubtleMinus;

  /// {@template containerLowest}
  /// The color of the lowest container.
  /// {@endtemplate}
  T get containerLowest;

  /// {@template containerLow}
  /// The color of the low container.
  /// {@endtemplate}
  T get containerLow;

  /// {@template container}
  /// The color of the container.
  /// {@endtemplate}
  T get container;

  /// {@template containerHigh}
  /// The color of the high container.
  /// {@endtemplate}
  T get containerHigh;

  /// {@template containerHighest}
  /// The color of the highest container.
  /// {@endtemplate}
  T get containerHighest;

  /// Linearly interpolate with another object.
  SurfaceGroupInterface<T> lerp(
    covariant SurfaceGroupInterface<T>? other,
    double t,
  );
}
