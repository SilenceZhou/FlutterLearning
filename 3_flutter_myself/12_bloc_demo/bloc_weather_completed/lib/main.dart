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
import './settings/bloc.dart';

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
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 我们正在使用BlocProvider使用BlocProvider.of <ThemeBloc>（context）使我们的ThemeBloc全局可用。
    ///
    /// 同样，我们使用BlocProvider使SettingsBloc全局可访问，我们也将它置于dispose覆盖中。
    /// 但是，这一次，由于我们在同一级别使用BlocProvider暴露了多个Bloc，
    /// 我们可以通过使用BlocProviderTree小部件来消除一些嵌套。
    return BlocProviderTree(
      //使用多个全局bloc
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc),
        BlocProvider<SettingsBloc>(bloc: _settingsBloc),
      ],
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

  // @override
  // Widget build(BuildContext context) {
  //   /// 我们正在使用BlocProvider使用BlocProvider.of <ThemeBloc>（context）使我们的ThemeBloc全局可用。
  //   return BlocProvider(
  //     bloc: _themeBloc,
  //     child: BlocBuilder(
  //       bloc: _themeBloc,
  //       builder: (context, ThemeState themeState) {
  //         return MaterialApp(
  //           title: 'home page',
  //           theme: themeState.theme,
  //           home: WeatherPage(
  //             weatherRepository: widget.weatherRepository,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
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
