import 'package:flutter/material.dart';

/// Device sizes for testing.
class DeviceSizes {
  /// iPhone 11 screen size.
  static const BoxConstraints iphone11 = BoxConstraints(minWidth: 414, maxWidth: 414, minHeight: 896, maxHeight: 896);

  /// Create a square [BoxConstraints] with the given [size].
  static BoxConstraints square(double size) =>
      BoxConstraints(minWidth: size, maxWidth: size, minHeight: size, maxHeight: size);

  /// Create [BoxConstraints] from the given [size].
  static BoxConstraints fromSize(Size size) =>
      BoxConstraints(minWidth: size.width, maxWidth: size.width, minHeight: size.height, maxHeight: size.height);
}

/// Extension for [BoxConstraints] to copy the size.
extension BoxConstraintsX on BoxConstraints {
  /// Copy the size of the [BoxConstraints] with the given [width] and [height].
  BoxConstraints copySize({double? width, double? height}) =>
      copyWith(minWidth: width, maxWidth: width, minHeight: height, maxHeight: height);
}
