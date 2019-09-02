import 'package:flutter/material.dart';

class TransformationMaskingAnimationWidget extends StatefulWidget {
  @override
  _TransformationMaskingAnimationWidgetState createState() =>
      _TransformationMaskingAnimationWidgetState();
}

class _TransformationMaskingAnimationWidgetState
    extends State<TransformationMaskingAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _transtionAnimation;
  Animation _borderAnimation;

  void hander(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      /// 使动画反转 为什么只有一次  如果多次将如何操作?
      _controller.reverse();
    }
    if (status == AnimationStatus.dismissed) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    /// addStatusListener 可以添加到AnimationController 或者 Animation上
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener(hander);

    _transtionAnimation = Tween(begin: 50.0, end: 200.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(72.0),
      end: BorderRadius.circular(0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Transformation masking animation page"),
          ),
          body: Center(
            child: Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: _transtionAnimation.value,
                height: _transtionAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: _borderAnimation.value,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
