import 'package:flutter/material.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'third_page.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // 为了验证 取得bloc是main注入的值
  final CounterBloc _bloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _bloc,
        child: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, int count) {
            final _counterBloc = BlocProvider.of<CounterBloc>(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('Second Page'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThirdPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: BlocBuilder(
                /// 不论这个地方使用下面哪种方案都没办法取到最新的bloc
                /// 但是在thirdpage 里面使用  BlocProvider.of<CounterBloc>(context) 取到的是全局
                bloc: _counterBloc,
                // bloc: _bloc,
                // bloc: BlocProvider.of<CounterBloc>(context),
                builder: (BuildContext context, int count) {
                  return Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('$count'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: RaisedButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            _bloc.dispatch(CounterEvent.increment);
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ));
  }
}
