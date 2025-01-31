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
  T get onColorContrast;

  /// {@template onColorContrastMinus}
  /// The color on the surface with a lower contrast.
  /// {@endtemplate}
  T get onColorContrastDim;

  /// {@template onColorSubtlePlus}
  /// The color on the surface with a higher contrast, but more subtle.
  /// {@endtemplate}
  T get onColorSubtle;

  /// {@template onColorSubtleMinus}
  /// The color on the surface with a lower contrast, but more subtle.
  /// {@endtemplate}
  T get onColorSubtleDim;

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

  /// {@template link}
  /// The color of the link.
  /// {@endtemplate}
  T get link;

  /// Linearly interpolate with another object.
  SurfaceGroupInterface<T> lerp(
    covariant SurfaceGroupInterface<T>? other,
    double t,
  );
}
