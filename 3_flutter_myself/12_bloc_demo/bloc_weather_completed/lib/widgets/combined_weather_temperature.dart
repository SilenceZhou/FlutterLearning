import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_widget.dart';
import '../models/model.dart';
import '../settings/bloc.dart';

/// CombinedWeatherTemperature小部件是一个组合小部件，它显示当前天气和温度。
/// 我们仍然会模块化温度和WeatherConditions小部件，以便它们都可以重复使用。
class CombineWeatherTemperature extends StatelessWidget {
  final Weather weather;

  CombineWeatherTemperature({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: WeatherConditions(
                    weatherCondition: weather.condition,
                  )),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: BlocBuilder(
                  bloc: BlocProvider.of<SettingsBloc>(context),
                  builder: (BuildContext context, SettingsState state) {
                    return Temperature(
                      temperature: weather.temp,
                      hight: weather.maxTemp,
                      low: weather.minTemp,
                      units: state.temperatureUnits, // 这地方是切换华氏温度和摄氏温度的关键所在
                    );
                  },
                ),
              )
            ],
          ),
          Center(
            child: Text(
              weather.formattedCondition,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
