import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/cart_info_model.dart';

import 'cart_count.dart';

class CartItem extends StatelessWidget {
  CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    print(item.toString());
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0), //外边距
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          )),
      child: Row(
        children: <Widget>[
          _cartCheckButton(item),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(item),
        ],
      ),
    );
  }

  // 复选框
  Widget _cartCheckButton(CartInfoModel item) {
    return Container(
      child: Checkbox(
        value: true,
        activeColor: Colors.pink,
        onChanged: (bool isSelected) {},
      ),
    );
  }

  // 商品图片
  Widget _cartImage(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(item.images),
    );
  }

  // 商品名称
  Widget _cartGoodsName(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(),
        ],
      ),
    );
  }

  /// 商品价格
  Widget _cartPrice(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.delete_forever,
                color: Colors.black12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
