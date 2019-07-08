import 'package:flutter/material.dart';
import '../models/category_model.dart';

///  ChangeNotifier : 管理全量的听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {
    /// 添加全部
    BxMallSubDto all = BxMallSubDto();

    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';

    /// 重置数据
    childCategoryList = [all];

    /// 注意：如果要使用 addAll 传递进入的参数一定要是指定类型的list
    childCategoryList.addAll(list);

    /// 通知所有的听众
    notifyListeners();
  }
}
