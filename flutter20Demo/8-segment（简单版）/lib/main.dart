import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'segment',
      theme: ThemeData(
        primaryColor: Colors.lightBlue
      ),
      home: KeepAliveDome()
    );
  }
}




class KeepAliveDome extends StatefulWidget {
  _KeepAliveDomeState createState() => _KeepAliveDomeState();
}

// with 类似于多个继承
class _KeepAliveDomeState extends State<KeepAliveDome> with SingleTickerProviderStateMixin{


  TabController _controller;
  // 重写初始化 和  销毁方法
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =TabController(length: 3, vsync: this); //初始化方法
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose()
    super.dispose();

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keep Alive Demo'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car),),
            Tab(icon: Icon(Icons.directions_transit),),
            Tab(icon: Icon(Icons.directions_bike),),
          ],
        ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            Text('111'),
            Text('222'),
            Text('3333'),
          ],
        ),

    );
  }
}