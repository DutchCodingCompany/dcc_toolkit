// const naming is clear enough by itself.
//ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

// Margins
class Margins {
  static const horizontal4 = SizedBox(width: 4);
  static const horizontal8 = SizedBox(width: 8);
  static const horizontal12 = SizedBox(width: 12);
  static const horizontal16 = SizedBox(width: 16);
  static const horizontal24 = SizedBox(width: 24);
  static const horizontal32 = SizedBox(width: 32);
  static const horizontal48 = SizedBox(width: 48);

  static const vertical4 = SizedBox(height: 4);
  static const vertical8 = SizedBox(height: 8);
  static const vertical12 = SizedBox(height: 12);
  static const vertical16 = SizedBox(height: 16);
  static const vertical24 = SizedBox(height: 24);
  static const vertical32 = SizedBox(height: 32);
  static const vertical48 = SizedBox(height: 48);
}

// Paddings
class Paddings {
  static const empty = EdgeInsets.zero;

  static const horizontal4 = EdgeInsets.symmetric(horizontal: 4);
  static const horizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const horizontal12 = EdgeInsets.symmetric(horizontal: 12);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const horizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const horizontal32 = EdgeInsets.symmetric(horizontal: 32);
  static const horizontal48 = EdgeInsets.symmetric(horizontal: 48);

  static const vertical2 = EdgeInsets.symmetric(vertical: 2);
  static const vertical4 = EdgeInsets.symmetric(vertical: 4);
  static const vertical8 = EdgeInsets.symmetric(vertical: 8);
  static const vertical12 = EdgeInsets.symmetric(vertical: 12);
  static const vertical16 = EdgeInsets.symmetric(vertical: 16);
  static const vertical24 = EdgeInsets.symmetric(vertical: 24);
  static const vertical32 = EdgeInsets.symmetric(vertical: 32);
  static const vertical48 = EdgeInsets.symmetric(vertical: 48);

  static const all4 = EdgeInsets.all(4);
  static const all8 = EdgeInsets.all(8);
  static const all12 = EdgeInsets.all(12);
  static const all16 = EdgeInsets.all(16);
  static const all24 = EdgeInsets.all(24);
  static const all32 = EdgeInsets.all(32);
  static const all48 = EdgeInsets.all(48);

  static const top1 = EdgeInsets.only(top: 1);
  static const top2 = EdgeInsets.only(top: 2);
  static const top4 = EdgeInsets.only(top: 4);
  static const top8 = EdgeInsets.only(top: 8);
  static const top12 = EdgeInsets.only(top: 12);
  static const top16 = EdgeInsets.only(top: 16);
  static const top24 = EdgeInsets.only(top: 24);
  static const top32 = EdgeInsets.only(top: 32);
  static const top48 = EdgeInsets.only(top: 48);

  static const bottom1 = EdgeInsets.only(bottom: 1);
  static const bottom2 = EdgeInsets.only(bottom: 2);
  static const bottom4 = EdgeInsets.only(bottom: 4);
  static const bottom8 = EdgeInsets.only(bottom: 8);
  static const bottom12 = EdgeInsets.only(bottom: 12);
  static const bottom16 = EdgeInsets.only(bottom: 16);
  static const bottom24 = EdgeInsets.only(bottom: 24);
  static const bottom32 = EdgeInsets.only(bottom: 32);
  static const bottom48 = EdgeInsets.only(bottom: 48);

  static const left4 = EdgeInsets.only(left: 4);
  static const left8 = EdgeInsets.only(left: 8);
  static const left12 = EdgeInsets.only(left: 12);
  static const left16 = EdgeInsets.only(left: 16);
  static const left24 = EdgeInsets.only(left: 24);
  static const left32 = EdgeInsets.only(left: 32);
  static const left48 = EdgeInsets.only(left: 48);

  static const right4 = EdgeInsets.only(right: 4);
  static const right8 = EdgeInsets.only(right: 8);
  static const right12 = EdgeInsets.only(right: 12);
  static const right16 = EdgeInsets.only(right: 16);
  static const right24 = EdgeInsets.only(right: 24);
  static const right32 = EdgeInsets.only(right: 32);
  static const right48 = EdgeInsets.only(right: 48);

  static const start4 = EdgeInsetsDirectional.only(start: 4);
  static const start8 = EdgeInsetsDirectional.only(start: 8);
  static const start12 = EdgeInsetsDirectional.only(start: 12);
  static const start16 = EdgeInsetsDirectional.only(start: 16);
  static const start24 = EdgeInsetsDirectional.only(start: 24);
  static const start32 = EdgeInsetsDirectional.only(start: 32);
  static const start48 = EdgeInsetsDirectional.only(start: 48);

  static const end4 = EdgeInsetsDirectional.only(end: 4);
  static const end8 = EdgeInsetsDirectional.only(end: 8);
  static const end12 = EdgeInsetsDirectional.only(end: 12);
  static const end16 = EdgeInsetsDirectional.only(end: 16);
  static const end24 = EdgeInsetsDirectional.only(end: 24);
  static const end32 = EdgeInsetsDirectional.only(end: 32);
  static const end48 = EdgeInsetsDirectional.only(end: 48);
}

extension MergeMargins on SizedBox {
  /// Returns the sum of two [SizedBox].
  SizedBox operator +(SizedBox other) {
    return SizedBox(
      width: (width ?? 0.0) + (other.width ?? 0.0),
      height: (height ?? 0.0) + (other.height ?? 0.0),
      child: other.child,
    );
  }

  /// Returns the difference between two [SizedBox].
  SizedBox operator -(SizedBox other) {
    return SizedBox(
      width: (width ?? 0.0) - (other.width ?? 0.0),
      height: (height ?? 0.0) - (other.height ?? 0.0),
      child: other.child,
    );
  }
}
