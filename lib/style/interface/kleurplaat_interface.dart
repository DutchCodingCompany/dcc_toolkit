import 'package:dcc_toolkit/style/interface/color_group_interface.dart';
import 'package:dcc_toolkit/style/interface/surface_group_interface.dart';
import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';

/// {@template kleurplaat}
/// Group of colors defined for [KatjasKleurplaat].
/// {@endtemplate}
abstract interface class KleurplaatInterface<T> {
  /// {@template primary}
  /// The primary color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get primary;

  /// {@template primaryFill}
  /// The primary fill color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get primaryFill;

  /// {@template content}
  /// The content color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get content;

  /// {@template contentFill}
  /// The content fill color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get contentFill;

  /// {@template error}
  /// The error color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get error;

  /// {@template errorFill}
  /// The error fill color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get errorFill;

  /// {@template success}
  /// The success color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get success;

  /// {@template successFill}
  /// The success fill color group.
  /// {@endtemplate}
  ColorGroupInterface<T> get successFill;

  /// {@template surface}
  /// The surface group.
  /// {@endtemplate}
  SurfaceGroupInterface<T> get surface;
}
