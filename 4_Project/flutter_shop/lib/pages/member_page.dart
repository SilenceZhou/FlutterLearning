import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ],
      ),
    );
  }

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
}
