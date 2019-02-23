import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 该Demo两个知识点
    // 1.Stack层叠布局
    // 2.把组件赋值为变量
    var stack = Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage('http://img5.mtime.cn/mt/2019/01/09/171109.88229500_135X190X4.jpg'),
          radius: 100.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue
          ),
          padding: EdgeInsets.all(10.0),
          child: Text('SilenceZhou'),
        ),
      ],
    );

    return MaterialApp(
      title: 'Row Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack层叠布局'),
        ),
        body: Center(
          child: stack,
        )
      ),
    );
  }
}
