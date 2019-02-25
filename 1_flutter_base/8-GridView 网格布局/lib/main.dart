import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slincezhou',
        home: Scaffold(
          appBar: AppBar(
            title: Text('GridView 网格'),
          ),
          body: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0, //竖轴
              crossAxisSpacing: 10.0, //横轴
              childAspectRatio: 0.75, // 宽高比
            ),
            children: <Widget>[
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/25/112700.66692130_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/07/141550.78907967_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/02/02/113216.53857992_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/24/095735.15787277_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2018/11/27/084318.51885265_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/10/153736.10615279_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/25/112700.66692130_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/07/141550.78907967_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/02/02/113216.53857992_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/24/095735.15787277_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2018/11/27/084318.51885265_100X140X4.jpg',
                  fit: BoxFit.cover),
              Image.network(
                  'http://img5.mtime.cn/mt/2019/01/10/153736.10615279_100X140X4.jpg',
                  fit: BoxFit.cover),
            ],
          ),
          // body: GridView.count(
          //   padding: const EdgeInsets.all(20.0),
          //   crossAxisSpacing: 10.0,
          //   crossAxisCount: 3,
          //   children: <Widget>[
          //     const Text('Slincezhou'),
          //     const Text('Slincezhou2'),
          //     const Text('Slincezhou3'),
          //     const Text('Slincezhou4'),
          //     const Text('Slincezhou5'),
          //     const Text('Slincezhou6'),
          //   ],
          // ),
        ));
  }
}
