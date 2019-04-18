import 'package:flutter/material.dart';
import 'package:my_listview_effect/bloc/ListBloc.dart';
import 'package:my_listview_effect/componets/ItemEffect.dart';

class ListViewEffect extends StatefulWidget {
  final Duration duration;
  final List<Widget> children;

  ListViewEffect({Key key, this.duration, this.children});
  _ListViewEffect createState() => new _ListViewEffect();
}

class _ListViewEffect extends State<ListViewEffect> {
  ListBloc _listBloc;

  initState() {
    _listBloc = new ListBloc();
    super.initState();
  }

  Widget build(BuildContext context) {
    _listBloc.startAnimation(widget.children.length, widget.duration);
    print("widget.children.length = ${widget.children.length}");
    print("widget.duration = ${widget.duration}");

    return new Scaffold(
      body: new Container(
        child: new Container(
          height: MediaQuery.of(context).size.height, // 屏幕高度
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.children.length,
              itemBuilder: (context, position) {
                print("position = ${position}");
                return new ItemEffect(
                  child: widget.children[position],
                  duration: widget.duration,
                  position: position,
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _listBloc.dispose();
    super.dispose();
  }
}
