import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import '../../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../routers/application.dart';

class FloorTitle extends StatelessWidget {
  final String picture_address;
  FloorTitle({Key key, this.picture_address}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      child: Image.network(picture_address),
    );
  }
}

/// 楼层商品

class FloorContent extends StatelessWidget {
  final List floorList;

  FloorContent({Key key, this.floorList}) : super(key: key);

  Widget _firstRow(
    context,
  ) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorList[1]),
            _goodsItem(context, floorList[2]),
          ],
        )
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
          Application.router
              .navigateTo(context, '/detail?id=${goods["goodsId"]}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorList[1]),
        _goodsItem(context, floorList[2]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }
}
