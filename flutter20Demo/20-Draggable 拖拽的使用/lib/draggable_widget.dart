import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Offset offset;
  final Color widgetColor;
  const DraggableWidget({
    Key key,
    this.offset,
    this.widgetColor,
  }) : super(key: key);

  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset offset = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      // Draggable负责拖拽的控件,父层使用了它，子元素就可以拖动了
      child: Draggable(
        // 要传递的参数，在DragTarget里，会接受到这个参数。当然要在拖拽控件推拽到DragTarget的时候。
        data: widget.widgetColor, //拖拽要传递给接收器的参数
        // 放置你要推拽的元素，可以是容器，也可以是图片和文字
        child: Container(
          height: 100,
          width: 100,
          color: widget.widgetColor,
        ),
        // feedback:常用于设置推拽元素时的样子，在案例中当推拽的时候，
        // 我们把它的颜色透明度变成了50%。当然你还可以改变它的大小。
        feedback: Container(
          width: 50,
          height: 50,
          color: widget.widgetColor.withOpacity(0.5),
        ), //当拖动组件时候
        // 是当松开时的相应事件，经常用来改变推拽时到达的位置，改变时用setState来进行。
        onDraggableCanceled: (Velocity vel, Offset offset) {
          setState(() {
            this.offset = offset;
          });
        },
      ),
    );
  }
}
