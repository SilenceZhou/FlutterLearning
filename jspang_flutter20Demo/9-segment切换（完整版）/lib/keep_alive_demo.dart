import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin{

  int _counter = 0;
  
  @override
  bool get wantKeepAlive => true;

  void _incrementCounter(){
    setState(() {_counter++; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//主轴居中
          children: <Widget>[
            Text('点击一次增加一次'),
            Text(
              '$_counter',
              style:Theme.of(context).textTheme.display4,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),




    );
  }
}