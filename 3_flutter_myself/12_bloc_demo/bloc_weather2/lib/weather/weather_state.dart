import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/weather.dart';

/// WeatherEmpty - 我们的初始状态，由于用户尚未选择城市，因此没有天气数据
/// WeatherLoading - 在我们为某个城市取得天气时会发生的状态
/// WeatherLoaded - 如果我们能够成功获取特定城市的天气，将会出现这种状态
/// WeatherError - 如果我们无法获取给定城市的天气，将会出现这种状态。

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {
  @override
  String toString() => 'WeatherEmpty';
}

class WeatherLoading extends WeatherState {
  @override
  String toString() => 'WeatherLoading';
}

class WeatherLoaded extends WeatherState {
  @override
  String toString() => 'WeatherLoaded';

  final Weather weather;
  WeatherLoaded({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherError extends WeatherState {
  @override
  String toString() => 'WeatherError';
}
