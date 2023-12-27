import 'dart:ui';

/// Extension on [Color] to convert it to [ColorFilter].
extension ColorFilterExtension on Color {
  /// Convert [Color] to [ColorFilter].
  ColorFilter toColorFilter() {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}
