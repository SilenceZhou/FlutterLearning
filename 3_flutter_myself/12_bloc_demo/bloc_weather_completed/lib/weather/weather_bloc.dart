import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './weather_event.dart';
import './weather_state.dart';
import '../models/weather_repository.dart';
import '../models/weather.dart';

/// 我们的WeatherBloc非常简单。回顾一下，
/// 它将WeatherEvents转换为WeatherStates并且依赖于WeatherRepository
/// weatherbloc 将依赖 weatherRepository
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  /// 我们将initialState设置为WeatherEmpty，
  /// 因为最初用户没有选择城市。然后，剩下的就是实现mapEventToState
  @override
  Stream<WeatherState> mapEventToState(
    WeatherState currentState,
    WeatherEvent event,
  ) async* {
    /// 由于我们只处理FetchWeather事件，
    /// 所以我们需要做的是在获取FetchWeather事件时产生WeatherLoading状态，
    /// 然后尝试从WeatherRepository获取天气
    ///
    /// 如果我们能够成功检索天气，那么我们会产生WeatherLoaded状态，
    /// 如果我们无法检索天气，我们会产生WeatherError状态
    if (event is FetchWeather) {
      yield WeatherLoading();

      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }

    if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
