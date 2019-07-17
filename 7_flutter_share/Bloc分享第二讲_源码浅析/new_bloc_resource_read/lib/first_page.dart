import 'package:flutter/material.dart';
import 'framework/dart_bloc/bloc.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'second_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);

    return BlocBuilder(
        bloc: _counterBloc,
        builder: (BuildContext context, int count) {
          return Scaffold(
            appBar: AppBar(
              title: Text('FirstPage'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have pushed the button this many times:'),
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  RaisedButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _counterBloc.dispatch(CounterEvent.increment);
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext contentx) => SecondPage(),
                  ),
                );
              },
              child: Icon(Icons.arrow_forward),
            ),

            /// 两个按钮都为 FloatingActionButton 点击就报错
            // floatingActionButton: Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: FloatingActionButton(
            //         onPressed: () {
            //           _counterBloc.dispatch(CounterEvent.increment);
            //         },
            //         tooltip: 'Increment',
            //         child: Icon(Icons.add),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: FloatingActionButton(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (BuildContext contentx) => SecondPage(),
            //             ),
            //           );
            //         },
            //         child: Text('push'),
            //       ),
            //     )
            //   ],
            // ),
          );
        });
  }
}
