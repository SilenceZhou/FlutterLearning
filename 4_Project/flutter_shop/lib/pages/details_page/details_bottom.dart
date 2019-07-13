import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import 'dart:convert';
import 'package:flutter_shop/provide/cart_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.pink,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              print('加入购物车');
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
