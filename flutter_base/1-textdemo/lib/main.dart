import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget',
      home: Scaffold(
        body: Center(
          child: Text(
            '周云最帅，且会为技术人生奋斗一生',
            textAlign: TextAlign.right, //对齐方式
            maxLines: 1, //总共行数
            overflow: TextOverflow.ellipsis, //结尾格式
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 125, 45),
              decoration: TextDecoration.underline, // text下面的下划线
              // dotted 点虚线，dashed 短虚线 double双下划线 wavy波浪线
              decorationStyle: TextDecorationStyle.solid, // 下划线样式
            ),
          ),
        ),
      ),
    );
  }
}
