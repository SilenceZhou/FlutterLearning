import 'package:flutter/material.dart';
import 'right_back_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterDemo',
      theme: ThemeData(primarySwatch: Colors.blue),

      /// 右滑返回 iOS已经自带，可以作为适配Android
      home: RightBackDemo(),
    );
  }
}
