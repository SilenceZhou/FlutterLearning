import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

/* dis
@override
void dispose() { 
  
  super.dispose();
} */

// lsb listView.builder

class MyApp extends StatefulWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 获取一个随机颜色
  Color _zyramdomColor() {
    int a = Random().nextInt(255) % 255;
    int r = Random().nextInt(255) % 255;
    int g = Random().nextInt(255) % 255;
    int b = Random().nextInt(255) % 255;
    return Color.fromARGB(a, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('VSCode Use'),
          ),
          body: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
              color: _zyramdomColor(),
              child: Center(
                child: Text('来来来点我变色@@@@@'),
              ),
            ),
          )),
    );
  }
}
