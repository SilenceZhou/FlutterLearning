import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

enum CounterEvent { increment, decrement }

// 仅从类声明中我们可以看出我们CounterBloc将CounterEvents作为输入并输出整数。
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        // 如果不写 async* 则会报错
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }
}

class MyApp extends StatefulWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      home: BlocProvider<CounterBloc>(
        bloc: _counterBloc,
        child: CounterPage(),
      ),
    );
  }
}

/// 表示层与业务逻辑层分开
/// 我们CounterPage不知道用户按下按钮会发生什么; 它只是派遣一个事件来通知CounterBloc。
/// 此外，我们CounterBloc不知道国家发生了什么（反价值）; 它只是将CounterEvents整数转换成整数。
class CounterPage extends StatelessWidget {
  final Widget child;

  CounterPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 我们能够访问CounterBloc实例，
    // BlocProvider.of<CounterBloc>(context)因为我们将我们包装CounterPage在一个BlocProvider。
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc demo'),
      ),
      body: BlocBuilder(
        bloc: _counterBloc,
        builder: (BuildContext context, int count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _counterBloc.dispatch(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                _counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
