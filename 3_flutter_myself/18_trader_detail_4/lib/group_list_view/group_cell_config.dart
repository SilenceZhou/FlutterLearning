
import 'package:flutter/material.dart';

/// 分段信息
class SectionRecord {
  /// 行数
  int index; 
  /// 是否展开
  bool expand;

  SectionRecord({@required this.index, @required this.expand});

  @override
  String toString() {
    return ' index : ${this.index}, expand : ${this.expand}';
  }
}

/// cell 段和行的信息 ， 返回 选中的当前行
typedef IndexPathCallback = SectionRecord Function();

/// cell 点击操作
typedef CellClickCallback = dynamic Function();
