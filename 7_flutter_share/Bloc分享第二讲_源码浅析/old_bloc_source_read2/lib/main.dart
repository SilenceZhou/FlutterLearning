import 'package:flutter/material.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'framework/dart_bloc/dart_bloc.dart';
import 'bloc/bloc.dart';
import 'myhomepage.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('-----main-------');
    print("bloc = $bloc, transition = $transition");
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CounterBloc _bloc = CounterBloc();

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose(); // 以免内存泄露问题
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: _bloc, // 初始化（调用父类Bloc()）状态绑定
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// class SimpleBlocDelegate extends BlocDelegate {
//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print("bloc = $bloc, transition = $transition");
//   }
// }

// void main() {
//   BlocSupervisor.delegate = SimpleBlocDelegate();
//   runApp(BlocProvider(
//     bloc: CounterBloc(),
//     child: MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CounterBloc>(
//       bloc: BlocProvider.of<CounterBloc>(context),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }
