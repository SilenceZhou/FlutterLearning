import 'package:flutter/material.dart';

class ValueChangeAnimationWidget extends StatefulWidget {
  @override
  _ValueChangeAnimationWidgetState createState() =>
      _ValueChangeAnimationWidgetState();
}

class _ValueChangeAnimationWidgetState extends State<ValueChangeAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    /// 注意时间
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    /// 从某个值到某个值
    _animation = IntTween(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Value change animation page"),
          ),
          body: Center(
            child: Text(
              _animation.value.toString(),
              style: TextStyle(fontSize: 48.0),
            ),
          ),
        );
      },
    );
  }
}
