import 'package:flutter/material.dart';
import 'draggable_widget.dart';

class DraggableDemo extends StatefulWidget {
  _DraggableDemoState createState() => _DraggableDemoState();
}

class _DraggableDemoState extends State<DraggableDemo> {
  Color _draggableColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable 拖拽的使用'),
      ),
      body: Stack(
        children: <Widget>[
          DraggableWidget(
            offset: Offset(100, 150),
            widgetColor: Colors.tealAccent,
          ),
          DraggableWidget(
            offset: Offset(250, 150),
            widgetColor: Colors.redAccent,
          ),
          Center(
            // DragTarget :用来接收拖拽事件的控件，
            // 当把Draggable放到DragTarget里时，他会接收Draggable传递过来的值，然后用生成器改变组件状态。
            child: DragTarget(
              // onAccept : 当推拽到控件里时触发，经常在这里得到传递过来的值。
              onAccept: (Color color) {
                _draggableColor = color;
              },
              // builder 构造器，里边进行修改child值。
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 100,
                  height: 100,
                  color: _draggableColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
