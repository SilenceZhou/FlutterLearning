import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/models/cart_info_model.dart';

class CartProvide extends ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartInfoModelList = [];
  double allPrice = 0; // 总结价格
  int allGoodsCount = 0; // 商品总数量

  save(goodsId, goodsName, count, price, images) async {
    print('保存');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var tmp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tmpList = (tmp as List).cast();
    bool isHave = false;
    int ival = 0;
    tmpList.forEach((item) {
      if (item["goodsId"] == goodsId) {
        tmpList[ival]['count'] = item['count'] + 1;
        cartInfoModelList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };

      tmpList.add(newGoods);
      cartInfoModelList.add(CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tmpList).toString();
    // print('字符串 $cartString');
    // print('数据模型 $cartInfoModelList');
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartInfoModelList = [];
    // print('cartInfo 清空完成.......');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartInfoModelList = [];
    if (cartString == null) {
      cartInfoModelList = [];
    } else {
      List<Map> tmpList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      tmpList.forEach((item) {
        CartInfoModel model = CartInfoModel.fromJson(item);
        if (model.isCheck) {
          allPrice += (model.count * model.price);
          allGoodsCount += model.count;
        }
        cartInfoModelList.add(model);
      });

      notifyListeners();
    }
  }

  /// 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tmpList = (json.decode(cartString.toString()) as List).cast();
    int tmpIndex = 0;
    int delIndex = 0;
    tmpList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tmpIndex;
      }
    });
    tmpList.removeAt(delIndex);
    cartString = json.encode(tmpList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();

    notifyListeners();
  }
}
