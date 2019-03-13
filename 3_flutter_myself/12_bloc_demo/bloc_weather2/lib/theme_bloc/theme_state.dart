import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

// 不小心把这个地方写成抽象类了，抽象类不能进行对象的新建
class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  ThemeState({
    @required this.theme,
    @required this.color,
  })  : assert(theme != null),
        assert(color != null),
        super([theme, color]);
}
