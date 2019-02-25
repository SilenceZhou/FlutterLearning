import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatefulWidget {
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 可交互的浮动按钮 简称FAB
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'silencezhou',
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
      ),
      
      // 底部融合
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 底部工具栏
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        // 和fab融合 '举行里面有个圆形缺口'
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.airport_shuttle),
              color: Colors.white,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}