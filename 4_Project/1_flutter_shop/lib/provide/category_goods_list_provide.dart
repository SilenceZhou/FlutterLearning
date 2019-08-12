import 'package:flutter/material.dart';
import '../models/category_goods_list.dart';

///  ChangeNotifier : 管理全量的听众
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  /// 点击二级segment进行数据保存 - 便于切换
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;

    /// 通知所有监听者
    notifyListeners();
  }

  getMoreList(List<CategoryListData> list) {
    goodsList.addAll(list);

    /// 通知所有监听者
    notifyListeners();
  }
}
