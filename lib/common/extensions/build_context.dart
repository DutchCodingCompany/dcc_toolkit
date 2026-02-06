import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:dcc_toolkit/style/text_style/katjas_boekwerk.dart';
import 'package:flutter/material.dart';

/// Extension for [BuildContext] to get theme related data.
extension ThemingExtensions on BuildContext {
  /// Get [ThemeData] from [BuildContext].
  ThemeData get theme => Theme.of(this);

  /// Get Theme [ColorScheme] from [BuildContext].
  ColorScheme get colors => theme.colorScheme;

  /// Get Theme [KatjasBoekwerk] from [BuildContext].
  KatjasBoekwerk get katjasBoekwerk => theme.extension<KatjasBoekwerk>()!;

  /// Get [BoekwerkDecorator] from [BuildContext].
  BoekwerkDecorator get textThemesDecorator => BoekwerkDecorator(katjasBoekwerk, katjasKleurPlaat);

  /// Get [KatjasKleurplaat] from [BuildContext].
  KatjasKleurplaat get katjasKleurPlaat => theme.extension<KatjasKleurplaat>()!;
}
