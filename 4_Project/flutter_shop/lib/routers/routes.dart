import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('error ===> route was not found!!!');
    });

    /// 如何配置路由
    /// 跳转详情页
    router.define(detailPage, handler: detailHandler);
  }
}
