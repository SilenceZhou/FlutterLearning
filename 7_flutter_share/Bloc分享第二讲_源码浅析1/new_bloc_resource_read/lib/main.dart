import 'package:flutter/material.dart';
import 'framework/dart_bloc/bloc.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'first_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("bloc = $bloc, transition = $transition");
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    builder: (BuildContext context) => CounterBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CounterBloc>(context),
      builder: (BuildContext context, int count) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirstPage(),
        );
      },
    );
    // return BlocProvider(
    //   builder: (BuildContext context) => CounterBloc(),
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: FirstPage(),
    //   ),
    // );
  }
}
