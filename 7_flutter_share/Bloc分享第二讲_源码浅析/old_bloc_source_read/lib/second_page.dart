import 'package:flutter/material.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'framework/dart_bloc/dart_bloc.dart';
import 'bloc/bloc.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, int count) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text('$count'),
            ),
          );
        },
      ),
    );
  }
}
