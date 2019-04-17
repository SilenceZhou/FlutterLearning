import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Image.network(
            'https://gitee.com/SilenceZhou/TestTabbarIcon/raw/master/share.png',
          ),
        ),
      ),
    );
  }
}
