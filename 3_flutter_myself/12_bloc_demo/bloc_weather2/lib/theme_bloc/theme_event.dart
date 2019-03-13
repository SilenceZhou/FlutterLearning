import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import '../models/weather.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

class WeatherChanded extends ThemeEvent {
  final WeatherCondition condition;

  @override
  String toString() => 'WeatherChanded';

  WeatherChanded({@required this.condition})
      : assert(condition != null),
        super([condition]);
}
