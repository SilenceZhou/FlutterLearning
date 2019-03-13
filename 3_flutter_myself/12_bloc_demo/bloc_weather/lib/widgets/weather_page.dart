import 'dart:async';

import 'package:flutter/material.dart';

import '../models/model.dart';
import '../weather/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc/theme.dart';

import 'my_widget.dart';

/// WeatherPage Widget将是一个StatefulWidget，负责创建和处理WeatherBloc
class WeatherPage extends StatefulWidget {
  final WeatherRepository weatherRepository;

  WeatherPage({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    super.initState();
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Weather'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );

              /// 触发获取城市天气数据
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (_, WeatherState state) {
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;
              // 注意of后面是<>
              final themeBloc = BlocProvider.of<ThemeBloc>(context);
              themeBloc.dispatch(WeatherChanded(condition: weather.condition));

              _refreshCompleter?.complete();
              _refreshCompleter = Completer();

              /// 为了使用RefreshIndicator，我们必须创建一个Completer，
              /// 它允许我们生成一个Future，我们可以在以后完成。
              /// 用户可以通过下拉来刷新天气。
              /// 接下来，让我们通过创建ThemeBloc来处理看起来很简单的UI

              ///  我们还使用ThemeBloc的BlocBuilder包装我们的GradientContainer小部件，
              /// 以便我们可以重建GradientContainer并且它的子节点可以响应ThemeState更改
              return BlocBuilder(
                bloc: themeBloc,
                builder: (_, ThemeState themeState) {
                  return GradientContainer(
                    color: themeState.color,
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc.dispatch(
                          RefreshWeather(city: state.weather.location),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Location(location: weather.location),
                            ),
                          ),
                          Center(
                            child: Center(
                              child: LastUpdated(
                                dateTime: weather.lastUpdated,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child:
                                  CombineWeatherTemperature(weather: weather),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }
}
