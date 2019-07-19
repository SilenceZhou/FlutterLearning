import 'package:flutter/material.dart';
import 'framework/dart_bloc/bloc.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);
    return BlocBuilder(
      bloc: _counterBloc,
      builder: (BuildContext context, int count) {
        return Scaffold(
          appBar: AppBar(
            title: Text('SecondPage'),
          ),
          body: Container(
            child: Center(
              child: Text(
                '$count',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
        );
      },
    );
  }
}
