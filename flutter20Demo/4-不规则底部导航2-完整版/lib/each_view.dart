import 'package:flutter/material.dart';

/// 动态View
class EachView extends StatefulWidget {

  String _title;// 内容
  EachView(this._title);//从上一个页面

  @override //因为上面加了东西
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // widget内部属性
      appBar: AppBar(title: Text(widget._title),),
      body: Center(child: Text(widget._title),),
    );
  }
}