import 'package:flutter/material.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdPage'),
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
