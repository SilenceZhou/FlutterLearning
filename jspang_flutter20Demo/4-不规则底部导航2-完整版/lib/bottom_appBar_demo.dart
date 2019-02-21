import 'package:flutter/material.dart';
import 'each_view.dart';



class BottomAppBarDemo extends StatefulWidget {
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}




class _BottomAppBarDemoState extends State<BottomAppBarDemo> {

  List<Widget> _eachView;
  int _index = 0;
  @override
  void initState() { 
    super.initState();
    _eachView = List();
    _eachView
    ..add(EachView('Home'))
    ..add(EachView('Account'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _eachView[_index], //有各自的导航
      // 可交互的浮动按钮 简称FAB
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // builder 构造器
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return EachView('new page');
          }));
        },
        tooltip: 'silencezhou',
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
      ),

      // 底部融合
      /*
       * centerFloat : 浮在中间上面面
       * endFloat: 最右边 + 上面
       * endDocked : 最右边 + 嵌在底
       * centerDocked: 中间 + 嵌在底
       * endTop : 最右边 + 顶部 (没有导航才看得到)
       * miniStartTop : 最左边 + 顶部
       * startTop : 和  miniStartTop差不多
       */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 底部工具栏
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        // 和fab融合 '举行里面有个圆形缺口'
        shape: CircularNotchedRectangle(),
        child: Row(
          /* MainAxisSize：在主轴方向占有空间的值，默认是max。
            MainAxisSize的取值有两种：
            max：根据传入的布局约束条件，最大化主轴方向的可用空间；
            min：与max相反，是最小化主轴方向的可用空间；
          */
          mainAxisSize: MainAxisSize.max,
          // MainAxisAlignment：主轴方向上的对齐方式，会对child的位置起作用，默认是start
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.airport_shuttle),
              color: Colors.white,
              onPressed: (){
                setState(() {
                  _index = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}