import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget',
      home: Scaffold(
        body: Center(
          child: Container(
            // container的宽高相当于真个屏幕的宽高
            child: Text(
              'hello container',
              style: TextStyle(fontSize: 40, color: Colors.blue),
            ),
            alignment: Alignment.center,
            height: 300,
            width: 400,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
