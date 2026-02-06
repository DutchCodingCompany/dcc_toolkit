import 'package:dcc_toolkit/style/text_style/handschrift.dart';
import 'package:flutter/material.dart';

/// Extensions for [TextStyle].
extension TextStyleX on TextStyle {
  /// Converts this [TextStyle] to a [Handschrift].
  ///
  /// Provide additional [boldStyle] and [linkStyle] for [Handschrift].
  Handschrift toHandschrift({TextStyle? boldStyle, TextStyle? linkStyle}) {
    return Handschrift.fromTextStyle(this, boldStyle: boldStyle, linkStyle: linkStyle);
  }
}
