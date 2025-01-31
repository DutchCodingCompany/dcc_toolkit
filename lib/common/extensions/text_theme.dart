import 'package:flutter/material.dart';

extension LinkStyle on TextTheme {
  TextStyle get linkSmall => bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );

  TextStyle get linkMedium => bodyMedium!.copyWith(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );

  TextStyle get linkLarge => bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );
}
