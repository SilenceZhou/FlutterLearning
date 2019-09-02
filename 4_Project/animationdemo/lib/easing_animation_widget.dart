import 'package:flutter/material.dart';

class EasingAnimationWidget extends StatefulWidget {
  @override
  EasingAnimationWidgetState createState() => EasingAnimationWidgetState();
}

class EasingAnimationWidgetState extends State<EasingAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(hander);

    _controller.forward();
  }

  void hander(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(hander);
      _controller.reset();

      /// 如初屏幕动画
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Easing Animation demo"),
              ),
              body: Transform(
                transform: Matrix4.translationValues(
                    _animation.value * width, 0.0, 0.0),
                child: new Center(
                    child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.black12,
                )),
              ));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
