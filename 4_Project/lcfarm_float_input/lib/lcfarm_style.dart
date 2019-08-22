import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'lcfarm_color.dart';

/// @desc: 格式 颜色_字号  废弃
/// 静态只初始化一次（屏幕大小未取得，算出有问题），再次 build 时不会重新去计划
/// style前缀+10(10%)两位不透明度百分比+6位颜色值(FFFFFF字母统一大写)+下划线+字号大小
/// @time 2019/3/13 4:44 PM
/// @author chenyun
class LcfarmStyle {
  ///白色相关字号
  static final TextStyle styleFFFFFF_10 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(10),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_12 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_14 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60FFFFFF_12 = TextStyle(
    color: LcfarmColor.color60FFFFFF,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_18 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_20 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_24 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_32 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFFFFFF_36 = TextStyle(
    color: LcfarmColor.colorFFFFFF,
    fontSize: LcfarmSize.sp(36),
    fontWeight: FontWeight.normal,
  );

  ///黑色相关

  static final TextStyle style000000_12 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_14 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_18 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style000000_20 = TextStyle(
    color: LcfarmColor.color000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_30 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(30),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style08000000_12 = TextStyle(
    color: LcfarmColor.color08000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_12 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_14 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style24000000_16 = TextStyle(
    color: LcfarmColor.color24000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_12 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_13 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(13),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_14 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_16 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_18 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_20 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40000000_24 = TextStyle(
    color: LcfarmColor.color40000000,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_11 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_12 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_14 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_16 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style60000000_18 = TextStyle(
    color: LcfarmColor.color60000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_12 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_14 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_16 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(16),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_18 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_20 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_24 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_32 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_36 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(36),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style80000000_48 = TextStyle(
    color: LcfarmColor.color80000000,
    fontSize: LcfarmSize.sp(48),
    fontWeight: FontWeight.normal,
  );

  ///主色相关
  static final TextStyle style3776E9_10 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(10),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_11 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(11),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_12 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_14 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_18 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style3776E9_32 = TextStyle(
    color: LcfarmColor.color3776E9,
    fontSize: LcfarmSize.sp(32),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style074FD1_14 = TextStyle(
    color: LcfarmColor.color074FD1,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style074FD1_20 = TextStyle(
    color: LcfarmColor.color074FD1,
    fontSize: LcfarmSize.sp(20),
    fontWeight: FontWeight.normal,
  );

  ///colorFF6060相关
  static final TextStyle styleFF6060_14 = TextStyle(
    color: LcfarmColor.colorFF6060,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_14 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF6060_18 = TextStyle(
    color: LcfarmColor.colorFF6060,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_18 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(18),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style70FF6060_12 = TextStyle(
    color: LcfarmColor.color70FF6060,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle style40FF6060_12 = TextStyle(
    color: LcfarmColor.color40FF6060,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF3221_14 = TextStyle(
    color: LcfarmColor.colorFF3221,
    fontSize: LcfarmSize.sp(14),
    fontWeight: FontWeight.normal,
  );

  static final TextStyle styleFF3221_12 = TextStyle(
    color: LcfarmColor.colorFF3221,
    fontSize: LcfarmSize.sp(12),
    fontWeight: FontWeight.normal,
  );

  ///colorFF5656相关
  static final TextStyle styleFF5656_12 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(12),
  );

  static final TextStyle styleFF5656_14 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(14),
  );

  static final TextStyle styleFF5656_24 = TextStyle(
    color: LcfarmColor.colorFF5656,
    fontSize: LcfarmSize.sp(24),
    fontWeight: FontWeight.normal,
  );
}
