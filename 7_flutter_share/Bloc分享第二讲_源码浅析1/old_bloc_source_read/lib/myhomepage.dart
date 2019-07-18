import 'package:flutter/material.dart';
import 'framework/flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'second_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyHomePage'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(),
                  ),
                );
              }),
        ],
      ),
      body: BlocBuilder(
        bloc: _counterBloc,
        builder: (BuildContext context, int count) {
          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 200)),
                  Text('Count : $count'),
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: RaisedButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        _counterBloc.dispatch(CounterEvent.increment);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('push'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(),
            ),
          );

          // Navigator.of(context).push(new MaterialPageRoute(
          //   builder: (context) {
          //     return BlocProvider<CounterBloc>(
          //       bloc: _counterBloc, // 初始化（调用父类Bloc()）状态绑定
          //       child: SecondPage(),
          //     );
          //   },
          // ));
        },
      ),
      // floatingActionButton: Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: FloatingActionButton(
      //         child: Icon(Icons.add),
      //         onPressed: () {
      //           _counterBloc.dispatch(CounterEvent.increment);
      //         },
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: FloatingActionButton(
      //         child: Text('push'),
      //         onPressed: () {
      //           Navigator.of(context).push(new MaterialPageRoute(
      //             builder: (context) {
      //               return BlocProvider<CounterBloc>(
      //                 bloc: CounterBloc(), // 初始化（调用父类Bloc()）状态绑定
      //                 child: SecondPage(),
      //               );
      //             },
      //           ));
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
