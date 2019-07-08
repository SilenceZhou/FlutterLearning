import 'package:flutter/material.dart';
import 'pages/index_pages.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';

void main() {
  var childCategory = ChildCategory();
  var providers = Providers();
  providers..provide(Provider<ChildCategory>.value(childCategory));
  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    ),
  );
}

/// Awesome flutter 插件： 自动生成代码插件
/// esay-mock ： 假数据
/// 网站前后端分离 则没法使用伪造请求头
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 套一层 便于以后拓展
      child: MaterialApp(
        title: '百姓生活家',
        debugShowCheckedModeBanner: false, // 去掉debug
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
