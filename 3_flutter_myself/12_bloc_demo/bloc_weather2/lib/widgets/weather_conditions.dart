import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import '../models/model.dart';

/// 我们的WeatherConditions小部件将负责显示当前的天气状况（晴朗，阵雨，雷暴等......）以及匹配的图标。
class WeatherConditions extends StatelessWidget {
  final WeatherCondition weatherCondition;

  WeatherConditions({Key key, @required this.weatherCondition})
      : super(key: key);

  Image _imageConditonToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        image = Image.asset('assets/clear.png');
        break;

      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        image = Image.asset('assets/snow.png');
        break;

      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/cloudy.png');
        break;

      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = Image.asset('assets/rainy.png');
        break;

      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/thunderstorm.png');
        break;

      case WeatherCondition.unknown:
        image = Image.asset('assets/clear.png');
        break;

      default:
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _imageConditonToImage(weatherCondition),
    );
  }
}
