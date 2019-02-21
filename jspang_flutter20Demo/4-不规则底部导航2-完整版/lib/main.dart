import 'package:flutter/material.dart';
import 'bottom_appBar_demo.dart';


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自定义bottomTabbar',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      // 单独放一个文件里面进行定制
      home: BottomAppBarDemo(),
    );
  }
}