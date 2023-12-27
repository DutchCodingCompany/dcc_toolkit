// const naming is clear enough by itself.
//ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

class Sizes {
  static const double xxs = 4;
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

// Margins
class Margins {
  static const horizontal4 = SizedBox(width: Sizes.xxs);
  static const horizontal8 = SizedBox(width: Sizes.xs);
  static const horizontal12 = SizedBox(width: Sizes.s);
  static const horizontal16 = SizedBox(width: Sizes.m);
  static const horizontal24 = SizedBox(width: Sizes.l);
  static const horizontal32 = SizedBox(width: Sizes.xl);
  static const horizontal48 = SizedBox(width: Sizes.xxl);

  static const vertical4 = SizedBox(height: Sizes.xxs);
  static const vertical8 = SizedBox(height: Sizes.xs);
  static const vertical12 = SizedBox(height: Sizes.s);
  static const vertical16 = SizedBox(height: Sizes.m);
  static const vertical24 = SizedBox(height: Sizes.l);
  static const vertical32 = SizedBox(height: Sizes.xl);
  static const vertical48 = SizedBox(height: Sizes.xxl);
}

// Paddings
class Paddings {
  static const empty = EdgeInsets.zero;

  static const horizontal4 = EdgeInsets.symmetric(horizontal: Sizes.xxs);
  static const horizontal8 = EdgeInsets.symmetric(horizontal: Sizes.xs);
  static const horizontal12 = EdgeInsets.symmetric(horizontal: Sizes.s);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: Sizes.m);
  static const horizontal24 = EdgeInsets.symmetric(horizontal: Sizes.l);
  static const horizontal32 = EdgeInsets.symmetric(horizontal: Sizes.xl);
  static const horizontal48 = EdgeInsets.symmetric(horizontal: Sizes.xxl);

  static const vertical2 = EdgeInsets.symmetric(vertical: 2);
  static const vertical4 = EdgeInsets.symmetric(vertical: Sizes.xxs);
  static const vertical8 = EdgeInsets.symmetric(vertical: Sizes.xs);
  static const vertical12 = EdgeInsets.symmetric(vertical: Sizes.s);
  static const vertical16 = EdgeInsets.symmetric(vertical: Sizes.m);
  static const vertical24 = EdgeInsets.symmetric(vertical: Sizes.l);
  static const vertical32 = EdgeInsets.symmetric(vertical: Sizes.xl);
  static const vertical48 = EdgeInsets.symmetric(vertical: Sizes.xxl);

  static const all4 = EdgeInsets.all(Sizes.xxs);
  static const all8 = EdgeInsets.all(Sizes.xs);
  static const all12 = EdgeInsets.all(Sizes.s);
  static const all16 = EdgeInsets.all(Sizes.m);
  static const all24 = EdgeInsets.all(Sizes.l);
  static const all32 = EdgeInsets.all(Sizes.xl);
  static const all48 = EdgeInsets.all(Sizes.xxl);

  static const top1 = EdgeInsets.only(top: 1);
  static const top2 = EdgeInsets.only(top: 2);
  static const top4 = EdgeInsets.only(top: Sizes.xxs);
  static const top8 = EdgeInsets.only(top: Sizes.xs);
  static const top12 = EdgeInsets.only(top: Sizes.s);
  static const top16 = EdgeInsets.only(top: Sizes.m);
  static const top24 = EdgeInsets.only(top: Sizes.l);
  static const top32 = EdgeInsets.only(top: Sizes.xl);
  static const top48 = EdgeInsets.only(top: Sizes.xxl);

  static const bottom1 = EdgeInsets.only(bottom: 1);
  static const bottom2 = EdgeInsets.only(bottom: 2);
  static const bottom4 = EdgeInsets.only(bottom: Sizes.xxs);
  static const bottom8 = EdgeInsets.only(bottom: Sizes.xs);
  static const bottom12 = EdgeInsets.only(bottom: Sizes.s);
  static const bottom16 = EdgeInsets.only(bottom: Sizes.m);
  static const bottom24 = EdgeInsets.only(bottom: Sizes.l);
  static const bottom32 = EdgeInsets.only(bottom: Sizes.xl);
  static const bottom48 = EdgeInsets.only(bottom: Sizes.xxl);

  static const left4 = EdgeInsets.only(left: Sizes.xxs);
  static const left8 = EdgeInsets.only(left: Sizes.xs);
  static const left12 = EdgeInsets.only(left: Sizes.s);
  static const left16 = EdgeInsets.only(left: Sizes.m);
  static const left24 = EdgeInsets.only(left: Sizes.l);
  static const left32 = EdgeInsets.only(left: Sizes.xl);
  static const left48 = EdgeInsets.only(left: Sizes.xxl);

  static const right4 = EdgeInsets.only(right: Sizes.xxs);
  static const right8 = EdgeInsets.only(right: Sizes.xs);
  static const right12 = EdgeInsets.only(right: Sizes.s);
  static const right16 = EdgeInsets.only(right: Sizes.m);
  static const right24 = EdgeInsets.only(right: Sizes.l);
  static const right32 = EdgeInsets.only(right: Sizes.xl);
  static const right48 = EdgeInsets.only(right: Sizes.xxl);

  static const start4 = EdgeInsetsDirectional.only(start: Sizes.xxs);
  static const start8 = EdgeInsetsDirectional.only(start: Sizes.xs);
  static const start12 = EdgeInsetsDirectional.only(start: Sizes.s);
  static const start16 = EdgeInsetsDirectional.only(start: Sizes.m);
  static const start24 = EdgeInsetsDirectional.only(start: Sizes.l);
  static const start32 = EdgeInsetsDirectional.only(start: Sizes.xl);
  static const start48 = EdgeInsetsDirectional.only(start: Sizes.xxl);

  static const end4 = EdgeInsetsDirectional.only(end: Sizes.xxs);
  static const end8 = EdgeInsetsDirectional.only(end: Sizes.xs);
  static const end12 = EdgeInsetsDirectional.only(end: Sizes.s);
  static const end16 = EdgeInsetsDirectional.only(end: Sizes.m);
  static const end24 = EdgeInsetsDirectional.only(end: Sizes.l);
  static const end32 = EdgeInsetsDirectional.only(end: Sizes.xl);
  static const end48 = EdgeInsetsDirectional.only(end: Sizes.xxl);
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
