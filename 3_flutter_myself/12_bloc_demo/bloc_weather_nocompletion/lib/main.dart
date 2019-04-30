/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:13
/// Github:https://github.com/SilenceZhou

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 提供BlocProvider
import 'package:flutter/material.dart';
import './models/model.dart';
import './widgets/my_widget.dart';
import './theme_bloc/theme_bloc.dart';
import './theme_bloc/theme.dart';
import 'package:http/http.dart' as http;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      http.Client(),
    ),
  );

  runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatefulWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc _themeBloc = ThemeBloc();

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 我们正在使用BlocProvider使用BlocProvider.of <ThemeBloc>（context）使我们的ThemeBloc全局可用。
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (context, ThemeState themeState) {
          return MaterialApp(
            title: 'home page',
            theme: themeState.theme,
            home: WeatherPage(
              weatherRepository: widget.weatherRepository,
            ),
          );
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
// final WeatherRepository weatherRepository;

// MyApp({Key key, @required this.weatherRepository})
//     : assert(weatherRepository != null),
//       super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'home page',
//       home: WeatherPage(
//         weatherRepository: weatherRepository,
//       ),
//     );
//   }
// }
