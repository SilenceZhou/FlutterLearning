import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

void main() {
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
    return BlocProvider(
      builder: (BuildContext context) => _bloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================
//////========================================================

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('myhomepagestate 调用');

    CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, Random().nextInt(256) + 0,
              Random().nextInt(256) + 0, Random().nextInt(256) + 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Text('random num1: ${Random().nextInt(20)}'),
              Text('random num2: ${Random().nextInt(20)}'),
              Text('random num3: ${Random().nextInt(20)}'),
              BlocBuilder(
                bloc: _bloc,
                builder: (BuildContext context, int count) {
                  return Column(
                    children: <Widget>[
                      Text('random num3: ${Random().nextInt(20)}'),
                      Text(
                        '$count',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.dispatch(CounterEvent.increase);
          print("hello world onPressed");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
