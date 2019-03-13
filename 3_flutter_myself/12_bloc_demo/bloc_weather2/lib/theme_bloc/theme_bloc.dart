import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';
import '../models/weather.dart';

/// 虽然它是很多代码，但这里唯一的东西是将WeatherCondition转换为新的ThemeState的逻辑。
/// 我们现在可以更新我们的App小部件以创建ThemeBloc并使用BlocBuilder来响应ThemeState中的更改。

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(theme: ThemeData.light(), color: Colors.lightBlue);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeState currentState,
    ThemeEvent event,
  ) async* {
    if (event is WeatherChanded) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(WeatherCondition conditon) {
    ThemeState theme;
    print('conditon == $conditon');

    switch (conditon) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.orangeAccent,
          ),
          color: Colors.yellow,
        );
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.lightBlueAccent,
          ),
          color: Colors.lightBlue,
        );
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.blueGrey,
          ),
          color: Colors.grey,
        );
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.indigoAccent,
          ),
          color: Colors.indigo,
        );
        break;
      case WeatherCondition.thunderstorm:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.deepPurpleAccent,
          ),
          color: Colors.deepPurple,
        );
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
        break;
    }
    return theme;
  }
}
