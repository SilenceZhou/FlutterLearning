import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget',
      home: Scaffold(
        appBar: AppBar(
          // Material风格导航
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Image Demo'),
        ),
        body: Center(
          child: Container(
            child: Image.network(
              'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg',
              fit: BoxFit.scaleDown, //展示模式
              // 混合模式
              // color: Colors.lightBlue,
              // colorBlendMode: BlendMode.modulate,
              // 是否重复
              repeat: ImageRepeat.repeat,
            ),
            width: 400,
            height: 200,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
