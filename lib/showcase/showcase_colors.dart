import 'package:dcc_toolkit/dcc_toolkit.dart';
import 'package:material_ui/material_ui.dart';

/// The colors of the kit, taken from the Katjas kleurplaat of the app and from the color scheme when the
/// app does not have one.
class const ShowcaseColors({
  required final Color surface,
  required final Color onSurface,
  required final Color accent,
}) {
  /// Creates a [ShowcaseColors].
  this;

  /// Takes the colors from the theme of [context].
  factory of(BuildContext context) {
    final theme = Theme.of(context);
    final kleurplaat = theme.extension<KatjasKleurplaat>();

    return ShowcaseColors(
      surface: kleurplaat?.surface.color ?? theme.colorScheme.surface,
      onSurface: kleurplaat?.surface.onColorContrast ?? theme.colorScheme.onSurface,
      accent: kleurplaat?.primary.onColorSubtle ?? theme.colorScheme.primary,
    );
  }
}
