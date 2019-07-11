import 'package:flutter/material.dart';
import 'package:flutter_shop/models/detail_model.dart';
import '../service/service_method.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  // tabbar 切换方法
  changeLeftAndRight(String changeState) {
    if (changeState.toLowerCase() == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners(); // 需要改行来通知切换
  }

  /// 从后台获取数据
  /// 如果不加 async 会报如下错误:
  /* The following NoSuchMethodError was thrown building ListeningBuilder(animation: Instance of
     flutter: 'DetailInfoProvide', dirty, dependencies: [_InheritedProviders], state: _AnimatedState#5979f):
      flutter: The getter 'data' was called on null.
   */
  getGoodsInfo(String id) async {
    var formData = {
      'goodId': id,
    };
    await request('getGoodDetailById', formData).then((val) {
      var responseData = json.decode(val.toString());

      print(responseData);

      goodsInfo = DetailsModel.fromJson(responseData);
    });
  }
}
