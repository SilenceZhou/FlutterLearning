import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rich Text')),
      body: _richText(),
    );
  }

  /// 富文本
  /// https://www.jianshu.com/p/c4ee2a7a97d2
  Widget _richText() {
    return Center(
      child: Container(
        child: RichText(
          text: TextSpan(
              text: "This is",
              style: TextStyle(color: _randomColor(), fontSize: 18.0),
              children: <TextSpan>[
                TextSpan(
                  text: "\n Long Tap bold",
                  style: TextStyle(
                    color: _randomColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: LongPressGestureRecognizer()
                    ..onLongPress = () {
                      print("Long Press");
                    },
                ),
                TextSpan(
                  text: "\nDouble tap.",
                  style: TextStyle(
                      color: _randomColor(),
                      fontWeight: FontWeight.w100,
                      fontSize: 30),
                  recognizer: DoubleTapGestureRecognizer()
                    ..onDoubleTap = () {
                      print("Double Tap");
                    },
                ),
                TextSpan(
                  text: '\n Tap once red',
                  style: TextStyle(color: Colors.red, fontSize: 40),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Tap once");
                    },
                ),
              ]),
        ),
      ),
    );
  }

  /// 获取随机色
  /// https://www.jianshu.com/p/b2bc9cd27cc1
  Color _randomColor() {
    return Color.fromARGB(
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
    );
  }
}
