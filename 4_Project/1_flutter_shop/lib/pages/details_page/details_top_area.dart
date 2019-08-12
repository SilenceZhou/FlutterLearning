import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(builder: (context, child, val) {
      var goodsInfo =
          Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
      if (goodsInfo != null) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _goodsImage(goodsInfo.image1),
              _goodsName(goodsInfo.goodsName),
              _goodsNum(goodsInfo.goodsSerialNumber),
            ],
          ),
        );
      } else {
        return Text('数据加载中');
      }
    });
  }

  /// 商品图片
  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  /// 商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  /// 商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        '编号$num',
        style: TextStyle(
          color: Colors.black12,
        ),
      ),
    );
  }
}
