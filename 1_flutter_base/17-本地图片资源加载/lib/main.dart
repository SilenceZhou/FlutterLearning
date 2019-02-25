import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/**
 * 本地图片资源加载操作
 * 1.根目录新建图片资源文件夹，并放入图片资源
 * 2.配置pubspec.yaml里面assets
 * 3.直接使用Image.asset('images/123.jpg')就好
 */



// 最简单的本地图片资源加载
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:Image.asset('images/123.jpg')
//     );
//   }
// }

// 带导航的本地图片资源加载
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '加载本地图片资源',
      home: Scaffold(
        appBar: AppBar(title: Text('本地资源图片')),
        body: Center(child: Image.asset('images/123.jpg'),
      ),
      ),
    );
  }
}

