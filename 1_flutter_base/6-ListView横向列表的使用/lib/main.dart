import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slincezhou',
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView Demo2'),
            ),
            body: Center(
              child: Container(height: 300.0, child: MyList()),
            )));
  }
}

/// 组件
class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal, //横向滚动
      children: <Widget>[
        new Container(
          width: 300,
          color: Colors.red,
        ),
        new Container(
          width: 180,
          color: Colors.greenAccent,
        ),
        new Container(
          width: 180,
          color: Colors.brown,
        ),
        new Container(
          width: 180,
          color: Colors.greenAccent,
        ),
      ],
    );
  }
}
