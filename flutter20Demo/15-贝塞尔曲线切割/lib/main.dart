import 'package:flutter/material.dart';
import 'custom_clipper.dart';

void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,//默认是true 去掉默认debug小图片
      home: HomePage(),
    );
  }
}