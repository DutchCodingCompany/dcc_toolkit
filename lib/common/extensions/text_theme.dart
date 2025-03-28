import 'package:flutter/material.dart';

/// LinkStyle extension for [TextTheme].
extension LinkStyle on TextTheme {
  /// Link style for small text.
  TextStyle get linkSmall => bodySmall!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);

  /// Link style for medium text.
  TextStyle get linkMedium => bodyMedium!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);

  /// Link style for large text.
  TextStyle get linkLarge => bodyLarge!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
}
