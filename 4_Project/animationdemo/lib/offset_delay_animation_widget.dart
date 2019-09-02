import 'package:flutter/material.dart';

class OffsetDelayAnimationWidget extends StatefulWidget {
  @override
  _OffsetDelayAnimationWidgetState createState() =>
      _OffsetDelayAnimationWidgetState();
}

class _OffsetDelayAnimationWidgetState extends State<OffsetDelayAnimationWidget>
    with TickerProviderStateMixin {
  /// Ticker是在每次帧更改时通知动画的类。
  ///

  AnimationController _controller;
  Animation _animation;
  Animation _lateAnimation;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Offset Delay Animation demo"),
              ),
              body: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        /// 控件1和控件2的动画为同一动画
                        Transform(
                            transform: Matrix4.translationValues(
                                _animation.value * width, 0.0, 0.0),
                            child: Center(
                                child: Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                  width: 200.0,
                                  height: 30.0,
                                  color: Colors.black12),
                            ))),
                        Transform(
                            transform: Matrix4.translationValues(
                                _animation.value * width, 0.0, 0.0),
                            child: Center(
                                child: Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                  width: 200.0,
                                  height: 30.0,
                                  color: Colors.black12),
                            ))),

                        /// 最后一个用到了延动画
                        Transform(
                            transform: Matrix4.translationValues(
                                _lateAnimation.value * width, 0.0, 0.0),
                            child: Center(
                                child: Container(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Container(
                                  width: 200.0,
                                  height: 30.0,
                                  color: Colors.black12),
                            ))),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    /// 进入动画
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      ..addStatusListener(handler);

    /// 延迟动画
    _lateAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller,

        /// 动画执行时间0.2秒后的
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.fastOutSlowIn,
        )));

    _controller.forward();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();

      /// offset动画
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ));

      /// delay动画
      _lateAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _controller,

          /// Interval是一个可以返回Curve对象的类CurvedAnimation。间隔有两个重要参数。一个被称为begin其他被称为end。对于Interval，项目的开始是0.0结束，1.0因此您可以在这些值之间传递两个变量，以告诉动画在该确切点开始。
          curve: Interval(
            0.2,
            1.0,
            curve: Curves.fastOutSlowIn,
          )))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
      _controller.forward();
    }
  }
}
