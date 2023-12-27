import 'package:flutter/material.dart';

/// Extension for [BuildContext] to get theme related data.
extension ThemingExtensions on BuildContext {
  /// Get [ThemeData] from [BuildContext].
  ThemeData get theme => Theme.of(this);
  /// Get Theme [ColorScheme] from [BuildContext].
  ColorScheme get colors => theme.colorScheme;

  /// Get Theme [TextTheme] from [BuildContext].
  TextTheme get textThemes => theme.textTheme;
}
