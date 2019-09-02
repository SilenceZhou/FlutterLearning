import 'package:flutter/material.dart';

class ParentingAnimationWidget extends StatefulWidget {
  @override
  _ParentingAnimationWidgetState createState() =>
      _ParentingAnimationWidgetState();
}

class _ParentingAnimationWidgetState extends State<ParentingAnimationWidget>
    with TickerProviderStateMixin {
  Animation _growingAnimation;
  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _growingAnimation = Tween(begin: 10.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _animation = Tween(begin: -0.25, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
          ..addStatusListener(hander);
    _controller.forward();
  }

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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Parenting Animation Page"),
          ),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    /// 结合平移与放大动画
                    Transform(
                      transform: Matrix4.translationValues(
                          _animation.value * width, 0.0, 0.0),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _growingAnimation,
                          builder: (ctx, child) {
                            return Center(
                              child: Container(
                                color: Colors.yellow[200],
                                height: _growingAnimation.value,
                                width: _growingAnimation.value * 2,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    /// 只有平移动画
                    Transform(
                      transform: Matrix4.translationValues(
                          _animation.value * width, 0.0, 0.0),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            width: 200,
                            height: 100,
                            color: Colors.black12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
