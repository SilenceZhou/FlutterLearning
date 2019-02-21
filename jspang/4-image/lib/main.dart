import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var file = File('123.jpg');
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
            // 1.网络图片
            // child: Image.network(
            //   'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg',
            //   fit: BoxFit.scaleDown, //展示模式
            //   // 混合模式
            //   // color: Colors.lightBlue,
            //   // colorBlendMode: BlendMode.modulate,
            //   // 是否重复
            //   repeat: ImageRepeat.repeat,
            // ),
            child: Image.file(file, repeat: ImageRepeat.repeat,),
            width: 400,
            height: 200,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}



/// 文件加载图片待定