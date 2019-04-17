import 'dart:io';
import 'package:flutter/material.dart';

import 'package:trader_detail/models/trade_detail_model.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeCell extends StatefulWidget {
  TradeDetailModel tradeDetailModel;
  var index;
  TradeCell({
    Key key,
    @required this.tradeDetailModel,
    @required this.index,
  })  : assert(tradeDetailModel != null),
        assert(index != null),
        super(key: key);

  @override
  _TradeCellState createState() => _TradeCellState();
}

// 正常高度为 70
// 展开高度为 106
class _TradeCellState extends State<TradeCell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(
              'widget.index = ${widget.index}, widget.tradeDetailModel = ${widget.tradeDetailModel}');
        },
        child: Column(
          // 先看看如果没有container是否可以定制高度
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '${widget.tradeDetailModel.typeDetail}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
                Text(
                  '${widget.tradeDetailModel.outCome > 0 ? "-${widget.tradeDetailModel.outCome}" : "+${widget.tradeDetailModel.inCome}"}元',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: widget.tradeDetailModel.outCome > 0
                          ? Color(0xff10bfc7)
                          : Color(0xffff8A10)),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  '${widget.tradeDetailModel.dealTime}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
                Text(
                  '可以用余额${widget.tradeDetailModel.availableBalance}元',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: widget.tradeDetailModel.outCome > 0
                          ? Color(0xff10bfc7)
                          : Color(0xffff8A10)),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Image.file(
                  File('tradeDetail_greyBg.png'),
                  width: ScreenUtil.screenWidth - 30,
                  height: ScreenUtil.instance.setHeight(35),
                ),
                Center(
                  child: Text('${widget.tradeDetailModel.remain}'),
                ),
              ],
            ),
            Divider(),
          ],
        ));
  }
}
