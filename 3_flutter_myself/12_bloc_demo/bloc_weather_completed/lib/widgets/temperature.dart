import 'package:flutter/material.dart';
import 'package:bloc_weather/settings/bloc.dart';

class Temperature extends StatelessWidget {
  final double temperature;
  final double low;
  final double hight;
  final TemperatureUnits units;

  Temperature({
    Key key,
    this.temperature,
    this.low,
    this.hight,
    this.units,
  }) : super(key: key);

  // 默认数据下发是摄氏温度，现在转换为华氏温度
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();

  int _formattedTemperature(double t) =>
      units == TemperatureUnits.fahrenheit ? _toFahrenheit(t) : t.round();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text('${_formattedTemperature(temperature)}°',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
        ),
        Column(
          children: <Widget>[
            Text(
              'max:${_formattedTemperature(hight)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Text(
              'min: ${_formattedTemperature(low)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                  color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
