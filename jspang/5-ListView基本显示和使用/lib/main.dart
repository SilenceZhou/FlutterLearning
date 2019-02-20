import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '周云',
        home: Scaffold(
          appBar: AppBar(
            title: Text('ListView Demo'),
          ),
          body: ListView(
            children: <Widget>[
              // 1、一行 （多行copy一下），文案和图片列表
              // ListTile(
              //   leading: Icon(Icons.access_time),
              //   title: Text('access_time'),
              // )
              // 2.image 列表
              Image.network(
                  'http://seopic.699pic.com/photo/50035/0520.jpg_wh1200.jpg'),
              Image.network(
                  'http://seopic.699pic.com/photo/50042/3858.jpg_wh1200.jpg'),
              Image.network(
                  'http://seopic.699pic.com/photo/50027/8874.jpg_wh1200.jpg')
            ],
          ),
        ));
  }
}
