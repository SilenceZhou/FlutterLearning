import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './weather_api_client.dart';
import './weather.dart';

/// WeatherRepository充当客户端代码和数据提供者之间的抽象，因此作为开发功能的开发人员，
/// 不必知道数据的来源。
/// 我们的WeatherRepository将依赖于我们刚刚创建的WeatherApiClient，它将公开一个名为的公共方法，
/// 你猜对了，getWeather（String city）。
/// 没有人需要知道我们需要做两个API调用（一个用于locationId，一个用于天气），因为没有人真正关心。
/// 我们所关心的只是获取特定城市的天气。
class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  /// 获取天气数据
  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeatcher(locationId);
  }
}
