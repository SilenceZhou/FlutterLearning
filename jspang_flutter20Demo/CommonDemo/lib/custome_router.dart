import 'package:flutter/material.dart';


class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  CustomRoute(this.widget)
    :super(
      transitionDuration:Duration(seconds: 2),
      pageBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
      ) {
        return widget;
      },
      ///  transitionsBuilder 严格区分大小写
      transitionsBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child
      ){
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.fastOutSlowIn//动画曲线:快出慢进
          )),
          child: child,
        );
      }
    );
}