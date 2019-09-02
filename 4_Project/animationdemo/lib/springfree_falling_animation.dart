import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SpringFreeFallingAnimationWidget extends StatefulWidget {
  @override
  _SpringFreeFallingAnimationWidgetState createState() =>
      _SpringFreeFallingAnimationWidgetState();
}

class _SpringFreeFallingAnimationWidgetState
    extends State<SpringFreeFallingAnimationWidget>
    with TickerProviderStateMixin {
  double _squareEdgeSize = 200.0;
  SpringDescription _springDescription =
      SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0);
  SpringSimulation _springSimulation;
  AnimationController _animationController;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        lowerBound: double.negativeInfinity,
        upperBound: double.infinity)
      ..addListener(() {
        setState(() {
          _squareEdgeSize = _animationController.value;
        });
      });
  }

  void startAnimationWithDelay() async {
    if (!_animationController.isAnimating && mounted) {
      await Future.delayed(Duration(milliseconds: 500));
      _animationController.animateWith(_springSimulation);
    }
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    final double height = MediaQuery.of(context).size.height;
    _springSimulation = SpringSimulation(_springDescription, _squareEdgeSize,
        height, _animationController.velocity);
    startAnimationWithDelay();
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Spring free falling animation Page"),
          ),
          body: Transform(
            transform:
                Matrix4.translationValues(0.0, _squareEdgeSize - 200.0, 0.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.black12,
              ),
            ),
          ),
        );
      },
    );
  }
}
