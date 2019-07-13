import 'package:flutter/material.dart';
import 'pages/index_pages.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_list_provide.dart';
import 'provide/detail_info_provide.dart';
import 'package:fluro/fluro.dart';

import 'routers/application.dart';
import 'routers/routes.dart';

import 'package:flutter_bugly/flutter_bugly.dart';

import 'provide/cart_provide.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailInfoProvide = DetailInfoProvide();
  var cartProvide = CartProvide();

  var providers = Providers();

  FlutterBugly.init(
    iOSAppId: "e9bb23176b",
  );

  /// 注入
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailInfoProvide>.value(detailInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide));

  FlutterBugly.postCatchedException(() {
    runApp(ProviderNode(child: MyApp(), providers: providers));
  });
}

/// Awesome flutter 插件： 自动生成代码插件
/// esay-mock ： 假数据
/// 网站前后端分离 则没法使用伪造请求头
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 注入
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      // 套一层 便于以后拓展
      child: MaterialApp(
        onGenerateRoute: Application.router.generator, // 配置
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
