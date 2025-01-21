import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

/// A class that implements JsonConverter to convert Color objects to and from JSON.
class ColorConverter implements JsonConverter<Color, String> {
  /// A class that implements JsonConverter to convert Color objects to and from JSON.
  const ColorConverter();

  /// Converts a hexadecimal color string from JSON to a Color object.
  ///
  /// The input string [json] is expected to be a hexadecimal color string.
  /// The method returns a Color object representing the color.
  @override
  Color fromJson(String json) {
    var hexColor = json.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  /// Converts a Color object to a hexadecimal color string for JSON.
  ///
  /// The input [color] is a Color object.
  /// The method returns a string in the format #AARRGGBB, where AA is the alpha value,
  /// RR is the red value, GG is the green value, and BB is the blue value.
  /// Each value is a two-digit hexadecimal number.
  @override
  String toJson(Color color) {
    // Next flutter release (>3.27) will contain a new method `toARGB32` to replace `.value`.
    // Ignore this for now.
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }
}
