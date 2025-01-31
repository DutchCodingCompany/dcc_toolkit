import 'package:dcc_toolkit/style/kleurplaat/katjas_kleurplaat.dart';
import 'package:dcc_toolkit/style/text_style/text_themes_decorator.dart';
import 'package:flutter/material.dart';

/// Extension for [BuildContext] to get theme related data.
extension ThemingExtensions on BuildContext {
  /// Get [ThemeData] from [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// Get Theme [ColorScheme] from [BuildContext].
  ColorScheme get colors => theme.colorScheme;

  /// Get Theme [TextTheme] from [BuildContext].
  TextTheme get textThemes => theme.textTheme;

  /// Get [TextThemesDecorator] from [BuildContext].
  TextThemesDecorator get textThemesDecorator => TextThemesDecorator(
        textThemes,
        katjasKleurPlaat,
      );

  /// Get [KatjasKleurplaat] from [BuildContext].
  KatjasKleurplaat get katjasKleurPlaat => theme.extension<KatjasKleurplaat>()!;
}
