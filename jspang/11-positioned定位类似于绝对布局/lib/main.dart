import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 1.Positioned布局
    var stack =Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage('http://img5.mtime.cn/mt/2019/01/09/171109.88229500_135X190X4.jpg'),
          radius: 100.0,
        ),
        Positioned(//相当于绝对定位
          top: 10.0,
          left: 10.0,
          child: Text('SilenceZhou', style: TextStyle(color: Colors.red),),
        ),
        Positioned(//相当于绝对定位
          bottom: 10.0,
          right: 10.0,
          child: Text('SilenceZhou2'),
        ),
      ],
    );

    return MaterialApp(
      title: 'Positioned 层叠布局',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Positioned 层叠布局'),
        ),
        body: Center(
          child: stack,
        )
      ),
    );
  }
}
