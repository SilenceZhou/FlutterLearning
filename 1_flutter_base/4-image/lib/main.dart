import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var file = File('images/123.jpg');
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Demo'),
        ),
        body: ListView(
          children: <Widget>[
            Image.network(
              'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg',
              fit: BoxFit.scaleDown, //展示模式
              // 混合模式
              // color: Colors.lightBlue,
              // colorBlendMode: BlendMode.modulate,
              // 是否重复
              repeat: ImageRepeat.repeat,
              width: 200,
              height: 200,
            ),
            Image(
              image: AssetImage('images/tmp.png'),
              height: 200,
              width: 300,
            ),
            Image.asset('images/123.jpg'),
          ],
        ),
        // ),
      ),
    );
  }
}
