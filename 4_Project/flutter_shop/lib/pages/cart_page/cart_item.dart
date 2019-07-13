import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../models/cart_info_model.dart';

import 'cart_count.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/cart_provide.dart';

class CartItem extends StatefulWidget {
  CartInfoModel item;

  CartItem(this.item);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

// class CartItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //print(item.toString());
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
          _cartCheckButton(context, widget.item),
          _cartImage(widget.item),
          _cartGoodsName(widget.item),
          _cartPrice(context, widget.item),
        ],
      ),
    );
  }

  // 复选框
  Widget _cartCheckButton(BuildContext context, CartInfoModel item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool isSelected) {
          setState(() {
            item.isCheck = !item.isCheck;
          });
          print('isSelected = ${isSelected}');
        },
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
  Widget _cartPrice(BuildContext context, CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.goodsId);
              },
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