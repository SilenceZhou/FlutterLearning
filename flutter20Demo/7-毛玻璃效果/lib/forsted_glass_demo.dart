import 'package:flutter/material.dart';
import 'dart:ui';

class ForstedClassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 毛玻璃效果关键点
      body: Stack(
        children: <Widget>[
          ConstrainedBox(//约束性组件,作用：添加额外的约束条件到child上
            constraints: const BoxConstraints.expand(),
            child: Image.network('http://img5.mtime.cn/CMS/News/2019/02/22/095107.70750402_620X620.jpg'),
          ),
          Center(
            child: ClipRect(//可裁切的矩形
              child: BackdropFilter(//背景过滤器
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),//高斯模糊
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 700,
                    height: 500,
                    decoration: BoxDecoration(color: Colors.green.shade100),//盒子修饰器
                    child: Center(
                      child: Text('ZHOUYUN', style:Theme.of(context).textTheme.display3),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

      
    );
  }
}