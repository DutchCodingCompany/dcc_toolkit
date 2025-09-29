// const naming is clear enough by itself.
//ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

// Sizes
class Sizes {
  static const double px1 = 1;
  static const double px2 = 2;
  static const double px4 = 4;
  static const double px6 = 6;
  static const double px8 = 8;
  static const double px10 = 10;
  static const double px12 = 12;
  static const double px16 = 16;
  static const double px20 = 20;
  static const double px24 = 24;
  static const double px28 = 28;
  static const double px32 = 32;
  static const double px36 = 36;
  static const double px40 = 40;
  static const double px44 = 44;
  static const double px48 = 48;
}

// Margins
class Margins {
  static const horizontal1 = SizedBox(width: Sizes.px1);
  static const horizontal2 = SizedBox(width: Sizes.px2);
  static const horizontal4 = SizedBox(width: Sizes.px4);
  static const horizontal6 = SizedBox(width: Sizes.px6);
  static const horizontal8 = SizedBox(width: Sizes.px8);
  static const horizontal10 = SizedBox(width: Sizes.px10);
  static const horizontal12 = SizedBox(width: Sizes.px12);
  static const horizontal16 = SizedBox(width: Sizes.px16);
  static const horizontal20 = SizedBox(width: Sizes.px20);
  static const horizontal24 = SizedBox(width: Sizes.px24);
  static const horizontal28 = SizedBox(width: Sizes.px28);
  static const horizontal32 = SizedBox(width: Sizes.px32);
  static const horizontal36 = SizedBox(width: Sizes.px36);
  static const horizontal40 = SizedBox(width: Sizes.px40);
  static const horizontal44 = SizedBox(width: Sizes.px44);
  static const horizontal48 = SizedBox(width: Sizes.px48);

  static const vertical1 = SizedBox(height: Sizes.px1);
  static const vertical2 = SizedBox(height: Sizes.px2);
  static const vertical4 = SizedBox(height: Sizes.px4);
  static const vertical6 = SizedBox(height: Sizes.px6);
  static const vertical8 = SizedBox(height: Sizes.px8);
  static const vertical10 = SizedBox(height: Sizes.px10);
  static const vertical12 = SizedBox(height: Sizes.px12);
  static const vertical16 = SizedBox(height: Sizes.px16);
  static const vertical20 = SizedBox(height: Sizes.px20);
  static const vertical24 = SizedBox(height: Sizes.px24);
  static const vertical28 = SizedBox(height: Sizes.px28);
  static const vertical32 = SizedBox(height: Sizes.px32);
  static const vertical36 = SizedBox(height: Sizes.px36);
  static const vertical40 = SizedBox(height: Sizes.px40);
  static const vertical44 = SizedBox(height: Sizes.px44);
  static const vertical48 = SizedBox(height: Sizes.px48);
}

// Paddings
class Paddings {
  static const empty = EdgeInsets.zero;

  static const horizontal1 = EdgeInsets.symmetric(horizontal: Sizes.px1);
  static const horizontal2 = EdgeInsets.symmetric(horizontal: Sizes.px2);
  static const horizontal4 = EdgeInsets.symmetric(horizontal: Sizes.px4);
  static const horizontal6 = EdgeInsets.symmetric(horizontal: Sizes.px6);
  static const horizontal8 = EdgeInsets.symmetric(horizontal: Sizes.px8);
  static const horizontal10 = EdgeInsets.symmetric(horizontal: Sizes.px10);
  static const horizontal12 = EdgeInsets.symmetric(horizontal: Sizes.px12);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: Sizes.px16);
  static const horizontal20 = EdgeInsets.symmetric(horizontal: Sizes.px20);
  static const horizontal24 = EdgeInsets.symmetric(horizontal: Sizes.px24);
  static const horizontal28 = EdgeInsets.symmetric(horizontal: Sizes.px28);
  static const horizontal32 = EdgeInsets.symmetric(horizontal: Sizes.px32);
  static const horizontal36 = EdgeInsets.symmetric(horizontal: Sizes.px36);
  static const horizontal40 = EdgeInsets.symmetric(horizontal: Sizes.px40);
  static const horizontal44 = EdgeInsets.symmetric(horizontal: Sizes.px44);
  static const horizontal48 = EdgeInsets.symmetric(horizontal: Sizes.px48);

  static const vertical1 = EdgeInsets.symmetric(vertical: Sizes.px1);
  static const vertical2 = EdgeInsets.symmetric(vertical: Sizes.px2);
  static const vertical4 = EdgeInsets.symmetric(vertical: Sizes.px4);
  static const vertical6 = EdgeInsets.symmetric(vertical: Sizes.px6);
  static const vertical8 = EdgeInsets.symmetric(vertical: Sizes.px8);
  static const vertical10 = EdgeInsets.symmetric(vertical: Sizes.px10);
  static const vertical12 = EdgeInsets.symmetric(vertical: Sizes.px12);
  static const vertical16 = EdgeInsets.symmetric(vertical: Sizes.px16);
  static const vertical20 = EdgeInsets.symmetric(vertical: Sizes.px20);
  static const vertical24 = EdgeInsets.symmetric(vertical: Sizes.px24);
  static const vertical28 = EdgeInsets.symmetric(vertical: Sizes.px28);
  static const vertical32 = EdgeInsets.symmetric(vertical: Sizes.px32);
  static const vertical36 = EdgeInsets.symmetric(vertical: Sizes.px36);
  static const vertical40 = EdgeInsets.symmetric(vertical: Sizes.px40);
  static const vertical44 = EdgeInsets.symmetric(vertical: Sizes.px44);
  static const vertical48 = EdgeInsets.symmetric(vertical: Sizes.px48);

  static const all1 = EdgeInsets.all(Sizes.px1);
  static const all2 = EdgeInsets.all(Sizes.px2);
  static const all4 = EdgeInsets.all(Sizes.px4);
  static const all6 = EdgeInsets.all(Sizes.px6);
  static const all8 = EdgeInsets.all(Sizes.px8);
  static const all10 = EdgeInsets.all(Sizes.px10);
  static const all12 = EdgeInsets.all(Sizes.px12);
  static const all16 = EdgeInsets.all(Sizes.px16);
  static const all20 = EdgeInsets.all(Sizes.px20);
  static const all24 = EdgeInsets.all(Sizes.px24);
  static const all28 = EdgeInsets.all(Sizes.px28);
  static const all32 = EdgeInsets.all(Sizes.px32);
  static const all36 = EdgeInsets.all(Sizes.px36);
  static const all40 = EdgeInsets.all(Sizes.px40);
  static const all44 = EdgeInsets.all(Sizes.px44);
  static const all48 = EdgeInsets.all(Sizes.px48);

  static const top1 = EdgeInsets.only(top: Sizes.px1);
  static const top2 = EdgeInsets.only(top: Sizes.px2);
  static const top4 = EdgeInsets.only(top: Sizes.px4);
  static const top6 = EdgeInsets.only(top: Sizes.px6);
  static const top8 = EdgeInsets.only(top: Sizes.px8);
  static const top10 = EdgeInsets.only(top: Sizes.px10);
  static const top12 = EdgeInsets.only(top: Sizes.px12);
  static const top16 = EdgeInsets.only(top: Sizes.px16);
  static const top20 = EdgeInsets.only(top: Sizes.px20);
  static const top24 = EdgeInsets.only(top: Sizes.px24);
  static const top28 = EdgeInsets.only(top: Sizes.px28);
  static const top32 = EdgeInsets.only(top: Sizes.px32);
  static const top36 = EdgeInsets.only(top: Sizes.px36);
  static const top40 = EdgeInsets.only(top: Sizes.px40);
  static const top44 = EdgeInsets.only(top: Sizes.px44);
  static const top48 = EdgeInsets.only(top: Sizes.px48);

  static const bottom1 = EdgeInsets.only(bottom: Sizes.px1);
  static const bottom2 = EdgeInsets.only(bottom: Sizes.px2);
  static const bottom4 = EdgeInsets.only(bottom: Sizes.px4);
  static const bottom6 = EdgeInsets.only(bottom: Sizes.px6);
  static const bottom8 = EdgeInsets.only(bottom: Sizes.px8);
  static const bottom10 = EdgeInsets.only(bottom: Sizes.px10);
  static const bottom12 = EdgeInsets.only(bottom: Sizes.px12);
  static const bottom16 = EdgeInsets.only(bottom: Sizes.px16);
  static const bottom20 = EdgeInsets.only(bottom: Sizes.px20);
  static const bottom24 = EdgeInsets.only(bottom: Sizes.px24);
  static const bottom28 = EdgeInsets.only(bottom: Sizes.px28);
  static const bottom32 = EdgeInsets.only(bottom: Sizes.px32);
  static const bottom36 = EdgeInsets.only(bottom: Sizes.px36);
  static const bottom40 = EdgeInsets.only(bottom: Sizes.px40);
  static const bottom44 = EdgeInsets.only(bottom: Sizes.px44);
  static const bottom48 = EdgeInsets.only(bottom: Sizes.px48);

  static const left1 = EdgeInsets.only(left: Sizes.px1);
  static const left2 = EdgeInsets.only(left: Sizes.px2);
  static const left4 = EdgeInsets.only(left: Sizes.px4);
  static const left6 = EdgeInsets.only(left: Sizes.px6);
  static const left8 = EdgeInsets.only(left: Sizes.px8);
  static const left10 = EdgeInsets.only(left: Sizes.px10);
  static const left12 = EdgeInsets.only(left: Sizes.px12);
  static const left16 = EdgeInsets.only(left: Sizes.px16);
  static const left20 = EdgeInsets.only(left: Sizes.px20);
  static const left24 = EdgeInsets.only(left: Sizes.px24);
  static const left28 = EdgeInsets.only(left: Sizes.px28);
  static const left32 = EdgeInsets.only(left: Sizes.px32);
  static const left36 = EdgeInsets.only(left: Sizes.px36);
  static const left40 = EdgeInsets.only(left: Sizes.px40);
  static const left44 = EdgeInsets.only(left: Sizes.px44);
  static const left48 = EdgeInsets.only(left: Sizes.px48);

  static const right1 = EdgeInsets.only(right: Sizes.px1);
  static const right2 = EdgeInsets.only(right: Sizes.px2);
  static const right4 = EdgeInsets.only(right: Sizes.px4);
  static const right6 = EdgeInsets.only(right: Sizes.px6);
  static const right8 = EdgeInsets.only(right: Sizes.px8);
  static const right10 = EdgeInsets.only(right: Sizes.px10);
  static const right12 = EdgeInsets.only(right: Sizes.px12);
  static const right16 = EdgeInsets.only(right: Sizes.px16);
  static const right20 = EdgeInsets.only(right: Sizes.px20);
  static const right24 = EdgeInsets.only(right: Sizes.px24);
  static const right28 = EdgeInsets.only(right: Sizes.px28);
  static const right32 = EdgeInsets.only(right: Sizes.px32);
  static const right36 = EdgeInsets.only(right: Sizes.px36);
  static const right40 = EdgeInsets.only(right: Sizes.px40);
  static const right44 = EdgeInsets.only(right: Sizes.px44);
  static const right48 = EdgeInsets.only(right: Sizes.px48);

  static const start1 = EdgeInsetsDirectional.only(start: Sizes.px1);
  static const start2 = EdgeInsetsDirectional.only(start: Sizes.px2);
  static const start4 = EdgeInsetsDirectional.only(start: Sizes.px4);
  static const start6 = EdgeInsetsDirectional.only(start: Sizes.px6);
  static const start8 = EdgeInsetsDirectional.only(start: Sizes.px8);
  static const start10 = EdgeInsetsDirectional.only(start: Sizes.px10);
  static const start12 = EdgeInsetsDirectional.only(start: Sizes.px12);
  static const start16 = EdgeInsetsDirectional.only(start: Sizes.px16);
  static const start20 = EdgeInsetsDirectional.only(start: Sizes.px20);
  static const start24 = EdgeInsetsDirectional.only(start: Sizes.px24);
  static const start28 = EdgeInsetsDirectional.only(start: Sizes.px28);
  static const start32 = EdgeInsetsDirectional.only(start: Sizes.px32);
  static const start36 = EdgeInsetsDirectional.only(start: Sizes.px36);
  static const start40 = EdgeInsetsDirectional.only(start: Sizes.px40);
  static const start44 = EdgeInsetsDirectional.only(start: Sizes.px44);
  static const start48 = EdgeInsetsDirectional.only(start: Sizes.px48);

  static const end1 = EdgeInsetsDirectional.only(end: Sizes.px1);
  static const end2 = EdgeInsetsDirectional.only(end: Sizes.px2);
  static const end4 = EdgeInsetsDirectional.only(end: Sizes.px4);
  static const end6 = EdgeInsetsDirectional.only(end: Sizes.px6);
  static const end8 = EdgeInsetsDirectional.only(end: Sizes.px8);
  static const end10 = EdgeInsetsDirectional.only(end: Sizes.px10);
  static const end12 = EdgeInsetsDirectional.only(end: Sizes.px12);
  static const end16 = EdgeInsetsDirectional.only(end: Sizes.px16);
  static const end20 = EdgeInsetsDirectional.only(end: Sizes.px20);
  static const end24 = EdgeInsetsDirectional.only(end: Sizes.px24);
  static const end28 = EdgeInsetsDirectional.only(end: Sizes.px28);
  static const end32 = EdgeInsetsDirectional.only(end: Sizes.px32);
  static const end36 = EdgeInsetsDirectional.only(end: Sizes.px36);
  static const end40 = EdgeInsetsDirectional.only(end: Sizes.px40);
  static const end44 = EdgeInsetsDirectional.only(end: Sizes.px44);
  static const end48 = EdgeInsetsDirectional.only(end: Sizes.px48);
}

// Radiuses
class Radiuses {
  static const circular1 = BorderRadius.all(Radius.circular(Sizes.px1));
  static const circular2 = BorderRadius.all(Radius.circular(Sizes.px2));
  static const circular4 = BorderRadius.all(Radius.circular(Sizes.px4));
  static const circular6 = BorderRadius.all(Radius.circular(Sizes.px6));
  static const circular8 = BorderRadius.all(Radius.circular(Sizes.px8));
  static const circular10 = BorderRadius.all(Radius.circular(Sizes.px10));
  static const circular12 = BorderRadius.all(Radius.circular(Sizes.px12));
  static const circular16 = BorderRadius.all(Radius.circular(Sizes.px16));
  static const circular20 = BorderRadius.all(Radius.circular(Sizes.px20));
  static const circular24 = BorderRadius.all(Radius.circular(Sizes.px24));
  static const circular28 = BorderRadius.all(Radius.circular(Sizes.px28));
  static const circular32 = BorderRadius.all(Radius.circular(Sizes.px32));
  static const circular36 = BorderRadius.all(Radius.circular(Sizes.px36));
  static const circular40 = BorderRadius.all(Radius.circular(Sizes.px40));
  static const circular44 = BorderRadius.all(Radius.circular(Sizes.px44));
  static const circular48 = BorderRadius.all(Radius.circular(Sizes.px48));
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
