import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trader_detail/models/trade_detail_model.dart';

import 'package:trader_detail/my_widgets/trade_cell.dart';

class TradeDetailPage extends StatefulWidget {
  @override
  _TradeDetailPageState createState() => _TradeDetailPageState();
}

class _TradeDetailPageState extends State<TradeDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备的高度:${ScreenUtil.screenHeight}');
    print('设备的宽度:${ScreenUtil.screenWidth}');
    print('设备像素密度: ${ScreenUtil.pixelRatio}');

    return Scaffold(
      appBar: AppBar(
        title: Text('交易明细'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> tradeDetailModel = {
            "availableBalance": 0.18,
            "dealTime": "2019-04-01 16:37:00",
            "inCome": 0.09,
            "outCome": 0.00,
            "remain": "打卡奖励送红包，金额0.09元",
            "typeDetail": "奖励"
          };
          Map<String, dynamic> tradeDetailModel2 = {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.0,
            "balance": null,
            "dealTime": "2018-10-26 09:42:35",
            "inCome": 0.00,
            "outCome": 100.00,
            "remain": "用户提现",
            "remark": null,
            "typeDetail": "提现"
          };

          return TradeCell(
            tradeDetailModel: TradeDetailModel.fromJson(
                index % 2 == 0 ? tradeDetailModel : tradeDetailModel2),
            index: index,
          );
        },
      ),
    );
  }
}

// Map<String, dynamic> tradeDetailModel = {
//   "availableBalance": 0.18,
//   "dealTime": "2019-04-01 16:37:00",
//   "inCome": 0.09,
//   "outCome": 0.00,
//   "remain": "打卡奖励送红包，金额0.09元",
//   "typeDetail": "奖励"
// };
