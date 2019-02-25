import 'package:flutter/material.dart';

class ExpansionPanelListDemo extends StatefulWidget {
  _ExpansionPanelListDemoState createState() => _ExpansionPanelListDemoState();
}

class _ExpansionPanelListDemoState extends State<ExpansionPanelListDemo> {


  List<int> mList;//组成一个int类型数组，用来控制索引
  List<ExpandStateBen> expandStateList;//开展开的状态列表， ExpandStateBean是自定义的类

  // 内部构造方法，调用这个类的时候自动执行（这个方法本来就是有的，只是我们进行重写了）
  _ExpansionPanelListDemoState(){
    mList = List();
    expandStateList = List();
    for (var i=0; i<10; i++){
      mList.add(i);
      expandStateList.add(ExpandStateBen(i,false));
    }
  }


  _setCurrentIndex(int index, isExpand){
    setState(() {
      expandStateList.forEach((item){
        if (item.index ==index) {
          item.isOpen = !item.isOpen;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('expansion panel list'),),
       // ExpansionPanelList必须放到滚动控件下才能用,SingleChildScrollView是最简单的滚动组件
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          //交互回掉属性，里边是个匿名函数
          expansionCallback: (index, bol){
            // 调用内部方法 更改每行的状态
            _setCurrentIndex(index, bol);
          },
          children: mList.map((index){//对数组进行遍历
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text('this is No.$index'),
                  );
                },
                body:ListTile( ///这个地方一点要添加上body
                  title:Text('expansion no.$index')
                ),
                isExpanded: expandStateList[index].isOpen
              );
          }).toList(),
          ),
        ),
      );
  }
}


// 自定义扩展状态类
class ExpandStateBen {
  var isOpen;
  var index;
  // 构造方法
  ExpandStateBen(this.index, this.isOpen);
}