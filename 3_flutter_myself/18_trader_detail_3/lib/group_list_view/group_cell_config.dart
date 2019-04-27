
import 'package:flutter/material.dart';

/// 分段信息
class SectionRecord {
  int index;
  bool expand;
  SectionRecord({@required this.index, @required this.expand});
  @override
  String toString() {
    return ' index : ${this.index}, expand : ${this.expand}';
  }
}

/// cell 点击效果
typedef TradeCellCallback = SectionRecord Function(
    SectionRecord aSectionRecord);
