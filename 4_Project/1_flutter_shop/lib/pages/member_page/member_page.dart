import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'member_list.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          MemberList(),
        ],
      ),
    );
  }

  /// 头部视图
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: prefix0.Image.network(
                  'https://avatars1.githubusercontent.com/u/9305458?s=40&v=4'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '云帅',
              style: TextStyle(
                color: Colors.black54,
                fontSize: ScreenUtil().setSp(36),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 我的订单标题
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  // 订单区域UI布局
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode, size: 30),
                Text('待付款'),
              ],
            ),
          ),
          //-------------------------------

          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder, size: 30),
                Text('待发货'),
              ],
            ),
          ),
          //-------------------------------

          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car, size: 30),
                Text('待收货'),
              ],
            ),
          ),
          //-------------------------------

          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.comment, size: 30),
                Text('待评价'),
              ],
            ),
          ),
          //-------------------------------
        ],
      ),
    );
  }
}
