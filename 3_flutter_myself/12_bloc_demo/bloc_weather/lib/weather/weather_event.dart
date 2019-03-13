import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);
}

/// 每当用户输入一个城市时，我们将发送一个具有给定城市的FetchWeather事件，
/// 我们的团队将负责确定那里的天气并返回一个新的WeatherState
class FetchWeather extends WeatherEvent {
  final String city;

  /// 这里为什么是super[city]
  FetchWeather({@required this.city})
      : assert(city != null),
        super([city]);
}

/// 为了支持pull-to-refresh，我们需要更新WeatherBloc来处理第二个事件：RefreshWeather。
class RefreshWeather extends WeatherEvent {
  @override
  String toString() => 'RefreshWeather';

  final String city;
  RefreshWeather({@required this.city})
      : assert(city != null),
        super([city]);
}
