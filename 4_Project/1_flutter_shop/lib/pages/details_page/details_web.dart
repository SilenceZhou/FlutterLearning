import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;

    return Provide<DetailInfoProvide>(
      builder: (context, child, data) {
        bool isLeft = Provide.value<DetailInfoProvide>(context).isLeft;
        bool isRight = Provide.value<DetailInfoProvide>(context).isRight;

        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            height: ScreenUtil().setHeight(200),
            alignment: Alignment.center,
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}
