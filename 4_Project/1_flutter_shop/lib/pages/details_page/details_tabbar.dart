import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailInfoProvide>(context).isLeft;
        var isRight = Provide.value<DetailInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isLeft),
              _myTabBarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  /// 右侧tabbar
  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        print('right : ${Provide.value<DetailInfoProvide>(context).isRight}');
        Provide.value<DetailInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1.0,
            color: isRight ? Colors.pink : Colors.black12,
          )),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// 左侧
  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        print('left : ${Provide.value<DetailInfoProvide>(context).isLeft}');
        Provide.value<DetailInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1.0,
            color: isLeft ? Colors.pink : Colors.black12,
          )),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
