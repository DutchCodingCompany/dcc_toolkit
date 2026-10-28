import 'package:material_ui/material_ui.dart';

/// The colors of the kit. They are those of Dutch Coding Company rather than of the app, so an explanation is
/// clearly not part of the app it explains.
abstract final class ShowcaseColors {
  /// The card of an explanation.
  static const surface = Color(0xFF0D2244);

  /// The outline of the card.
  static const outline = Color(0xFF17335E);

  /// Titles on [surface], and the ring around the part that is explained.
  static const onSurface = Color(0xFFFFFFFF);

  /// Body text and icons on [surface].
  static const onSurfaceDim = Color(0xFFEAF2FF);

  /// Steps that are not the current one.
  static const subtle = Color(0x1AFFFFFF);

  /// Buttons on [surface].
  static const inverse = Color(0xFFFFFFFF);

  /// Labels on [inverse].
  static const onInverse = Color(0xFF08162B);

  /// Icons on [inverse].
  static const onInverseDim = Color(0xFF0D2244);

  /// Dims the app around the part that is explained.
  static const scrim = Color(0x4D08162B);

  /// The current step.
  static const accent = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF416FFF), Color(0xFF05D4FE)],
  );

  /// Shadows of the card.
  static const shadowClose = Color(0x0F0D0D0D);

  /// Shadows of the card.
  static const shadowFar = Color(0x080D0D0D);
}
