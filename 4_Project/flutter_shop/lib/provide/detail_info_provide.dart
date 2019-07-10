import 'package:flutter/material.dart';
import 'package:flutter_shop/models/detail_model.dart';
import '../service/service_method.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  /// 从后台获取数据
  getGoodsInfo(String id) {
    var formData = {
      'goodId': id,
    };
    request('getGoodDetailById', formData).then((val) {
      var responseData = json.decode(val.toString());

      print(responseData);

      goodsInfo = DetailsModel.fromJson(responseData);
    });
  }
}
