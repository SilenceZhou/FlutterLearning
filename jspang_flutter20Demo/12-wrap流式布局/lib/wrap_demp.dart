import 'package:flutter/material.dart';

class WrapDemo extends StatefulWidget {
  _WrapDemoState createState() => _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {

  List<Widget> list;
  @override
  void initState() { //初始化list
    super.initState();
    // 先新建一个空数组，然后往里面添加数据
    list = List<Widget>()..add(buildAddButton());
  }

  @override
  Widget build(BuildContext context) {

    // 获取屏幕的宽高
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Wrap流式布局'),),
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height/2,
            color: Colors.grey,
            child: Wrap(
              children: list,
              spacing: 25.0,
            ),
          ),
        ),
      ),
    );
  }


  Widget buildAddButton(){ // 添加按钮
    return GestureDetector(
      onTap: (){
        if (list.length < 12) {
          setState(() { // 因为没有双向数据绑定，所以需要手动设置状态
            list.insert(list.length-1,buildPhoto());
          });
       }
      },
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          width: 90.0,
          height: 90.0,
          color: Colors.greenAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }



  Widget buildPhoto(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90.0,
        height: 90.0,
        color: Colors.amber,
        child: Center(child: Text('照片'),),
      ),
    );
  }



}