import 'package:flutter/material.dart';
import 'lcfarm_size.dart';
import 'lcfarm_color.dart';

/// @desc  格式 颜色_字号
/// @time 2019/3/13 4:44 PM
/// @author chenyun
///
/// Thin, the least thick w100
/// Extra-light  w200
/// Light w300
/// Normal / regular / plain w400
/// Medium w500
/// Semi-bold w600
/// Bold w700
/// Extra-bold w800
/// Black, the most thick  w900
/// The default font weight. normal = w400;

enum LCFontWeigthType { Thin, Normal, Medium, Bold }

class LcfarmStyle {
  static FontWeight lc_fontWeight(LCFontWeigthType weightType) {
    FontWeight weight;
    switch (weightType) {
      case LCFontWeigthType.Thin:
        weight = FontWeight.w300;
        break;

      case LCFontWeigthType.Normal:
        weight = FontWeight.normal;
        break;

      case LCFontWeigthType.Medium:
        weight = FontWeight.w500;
        break;

      case LCFontWeigthType.Bold:
        weight = FontWeight.w700;
        break;

      default:
        weight = FontWeight.normal;
        break;
    }
    return weight;
  }

  static TextStyle textStyle(
    Color color,
    double fontSize,
    LCFontWeigthType weightType, [
    double lineSpacing = 1.0,
  ]) {
    return TextStyle(
      color: color,
      fontSize: LcfarmSize.sp(fontSize),
      fontWeight: lc_fontWeight(weightType),
      height: lineSpacing,
    );
  }

  static final TextStyle style3776E9_18 = TextStyle(
    color: LcfarmColor.colorff3776E9,
    fontSize: LcfarmSize.sp(18),
  );

  static final TextStyle style60000000_18 = TextStyle(
    color: LcfarmColor.color08000000,
    fontSize: LcfarmSize.sp(18),
  );

  static final TextStyle style60000000_16 = TextStyle(
    color: LcfarmColor.color08000000,
    fontSize: LcfarmSize.sp(16),
  );

  static final TextStyle style80000000_18 = TextStyle(
    color: LcfarmColor.color08000000,
    fontSize: LcfarmSize.sp(18),
  );

  static final TextStyle style333333_14_w400 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.w400,
  );
  static final TextStyle style333333_15_w400 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(15),
    fontWeight: FontWeight.w400,
  );
  static final TextStyle style333333_17_w400 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(17),
    fontWeight: FontWeight.w400,
  );

  ///白色相关字号
  static final TextStyle styleFFFFFF_12 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(12),
  );

  ///白色相关字号
  static final TextStyle styleFFFFFF_10 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(10),
  );

  static final TextStyle styleFFFFFF_13 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(13),
  );

  static final TextStyle styleFFFFFF_15 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(15),
  );

  static final TextStyle styleFFFFFF_18 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(18),
  );

  ///灰色相关字号
  static final TextStyle style999999_11 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(11),
  );

  static final TextStyle style999999_12 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(12),
  );

  static final TextStyle style999999_13 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(13),
  );

  static final TextStyle style999999_14 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle style999999_17 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(17),
  );

  static final TextStyle style999999_18 = TextStyle(
    color: LcfarmColor.color999999,
    fontSize: LcfarmSize.sp(18),
  );

  static final TextStyle style333333_15 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(15),
  );

  static final TextStyle style333333_14 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle style333333_16 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(16),
  );

  static final TextStyle style333333_17 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(17),
  );

  static final TextStyle style333333_22 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(22),
  );

  static final TextStyle style333333_24 = TextStyle(
    color: LcfarmColor.color333333,
    fontSize: LcfarmSize.sp(24),
  );

  static final TextStyle style10BFC7_14 = TextStyle(
    color: LcfarmColor.color10BFC7,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle style8010BFC7_14 = TextStyle(
    color: LcfarmColor.color8010BFC7,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle styleC3C3C3_13 = TextStyle(
    color: LcfarmColor.colorC3C3C3,
    fontSize: LcfarmSize.sp(13),
  );

  static final TextStyle styleC3C3C3_16 = TextStyle(
    color: LcfarmColor.colorC3C3C3,
    fontSize: LcfarmSize.sp(16),
  );
  static final TextStyle style666666_12 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(12),
  );
  static final TextStyle style666666_13 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(13),
  );

  static final TextStyle style666666_14 = TextStyle(
    color: LcfarmColor.color666666,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle styleFF8A10_13 = TextStyle(
    color: LcfarmColor.colorFF8A10,
    fontSize: LcfarmSize.sp(13),
  );

  static final TextStyle styleFF8A10_16 = TextStyle(
    color: LcfarmColor.colorFF8A10,
    fontSize: LcfarmSize.sp(16),
  );
}
