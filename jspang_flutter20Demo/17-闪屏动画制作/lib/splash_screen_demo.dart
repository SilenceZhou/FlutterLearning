import 'package:flutter/material.dart';
import 'homepage.dart';


// 动态组件
class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _controller;//Animation的子类，用来控制动画的（时间，动画路径等）
  Animation _animation;

  @override
  void initState() {
    
    super.initState();
    // vsync:this 垂直同步设置  Duration(milliseconds: 3000):动画使用毫秒级别
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // 监听事件
    // 动画事件监听器，它可以监听到动画的执行状态，我们这里只监听动画是否结束，如果结束则执行页面跳转动作。
    _animation.addStatusListener((status){
      if (status == AnimationStatus.completed) { // 动画已经执行完毕。

        // 路由跳转 (pushAndRemoveUntil: 跳转指定路由，并销毁之前路由。-> 跳转指定页面并销毁当前面)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)=>MyHomePage()),
          (route)=>route==null);
      }
    });

    _controller.forward();//播放动画

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        'http://desk.fd.zol-img.com.cn/t_s1680x1050c5/g5/M00/09/01/ChMkJlwThk-IH5f7AAKFQvC40v4AAtyjQAH-CoAAoVa592.jpg?downfile=1550826654874.jpg',
        scale: 2.0,
        fit:BoxFit.cover//填充模式
      ),
      
    );
  }
}