import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trader_detail/models/trade_detail_total_model.dart';
import 'package:trader_detail/my_widgets/trade_cell.dart';
import 'package:trader_detail/models/trade_detail_model.dart';

import 'grouped_listview.dart';

class TradeDetailPage extends StatefulWidget {
  @override
  _TradeDetailPageState createState() => _TradeDetailPageState();
}

class _TradeDetailPageState extends State<TradeDetailPage> {
  SectionRecord _sectionRecord;
  @override
  Widget build(BuildContext context) {
    /// 一定要在第一个build里面进行初始化，这个时候才能获取到屏幕
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    TradeDetailTotalModel model = loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text('交易明细'),
      ),
      body: GoupListView<TradeDetailModel, String>(
        collection: model.data.list,
        groupBy: (TradeDetailModel model) => model.dealTime.substring(0, 7),
        listBuilder: (BuildContext context, TradeDetailModel model) {
          return TradeCell(
            tradeDetailModel: model,
            // index: index,
            // tradeCellCallback: (SectionRecord aSectionRecord) {
            //   setState(() {
            //     if (_sectionRecord == null) {
            //       _sectionRecord = SectionRecord(index: index, expand: true);
            //     } else if (_sectionRecord.index == index) {
            //       _sectionRecord.expand = !_sectionRecord.expand;
            //       _sectionRecord.index = index;
            //     } else {
            //       _sectionRecord.index = index;
            //       _sectionRecord.expand = true;
            //     }
            //   });
            //   return _sectionRecord;
            // },
          );
        },
        groupBuilder: header,
      ),
      // body: ListView.builder(
      //   itemCount: model.data.list.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return TradeCell(
      //       tradeDetailModel: model.data.list[index],
      //       index: index,
      //       tradeCellCallback: (SectionRecord aSectionRecord) {
      //         setState(() {
      //           if (_sectionRecord == null) {
      //             _sectionRecord = SectionRecord(index: index, expand: true);
      //           } else if (_sectionRecord.index == index) {
      //             _sectionRecord.expand = !_sectionRecord.expand;
      //             _sectionRecord.index = index;
      //           } else {
      //             _sectionRecord.index = index;
      //             _sectionRecord.expand = true;
      //           }
      //         });
      //         return _sectionRecord;
      //       },
      //     );
      //   },
      // ),
    );
  }

  Widget header(BuildContext context, String name) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15),
      child: Text(name),
    );
  }

  /// 数据处理
  List<dynamic> dealTime(List originList) {}

  /// 目前为模拟数据 待替换
  TradeDetailTotalModel loadData() {
    Map<String, dynamic> data = {
      "code": 0,
      "data": {
        "endTime": "2019-04-01",
        "hasMonthlyBill": true,
        "list": [
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.18,
            "balance": null,
            "dealTime": "2019-12-01 16:37:00",
            "inCome": 0.09,
            "outCome": 0.00,
            "remain": "打卡奖励送红包，金额0.09元",
            "remark": null,
            "typeDetail": "奖励"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.09,
            "balance": null,
            "dealTime": "2019-12-18 16:16:00",
            "inCome": 0.09,
            "outCome": 0.00,
            "remain": "打卡奖励送红包，金额0.09元",
            "remark": null,
            "typeDetail": "奖励"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.0,
            "balance": null,
            "dealTime": "2019-12-01 10:21:37",
            "inCome": 0.00,
            "outCome": 100.15,
            "remain": "用户提现",
            "remark": null,
            "typeDetail": "提现"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.15,
            "balance": null,
            "dealTime": "2019-12-30 16:13:01",
            "inCome": 0.09,
            "outCome": 0.00,
            "remain": "打卡奖励送红包，金额0.09元",
            "remark": null,
            "typeDetail": "奖励"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.06,
            "balance": null,
            "dealTime": "2019-10-29 15:28:12",
            "inCome": 0.06,
            "outCome": 0.00,
            "remain": "打卡奖励送红包，金额0.06元",
            "remark": null,
            "typeDetail": "奖励"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2019-10-29 02:15:13",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.0,
            "balance": null,
            "dealTime": "2019-10-29 00:13:03",
            "inCome": 0.00,
            "outCome": 100.00,
            "remain": "用户提现",
            "remark": null,
            "typeDetail": "提现"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2018-10-28 19:35:13",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          },
          {
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
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2018-09-25 15:18:35",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2018-09-29 02:15:13",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.0,
            "balance": null,
            "dealTime": "2018-09-29 00:13:03",
            "inCome": 0.00,
            "outCome": 100.00,
            "remain": "用户提现",
            "remark": null,
            "typeDetail": "提现"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2018-08-28 19:35:13",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 0.0,
            "balance": null,
            "dealTime": "2018-08-26 09:42:35",
            "inCome": 0.00,
            "outCome": 100.00,
            "remain": "用户提现",
            "remark": null,
            "typeDetail": "提现"
          },
          {
            "accountType": null,
            "accountTypeName": null,
            "availableBalance": 100.0,
            "balance": null,
            "dealTime": "2018-08-25 15:18:35",
            "inCome": 100.00,
            "outCome": 0.00,
            "remain": "账户线上充值",
            "remark": null,
            "typeDetail": "充值"
          }
        ],
        "page": {"pageNum": 1, "pages": 22, "totalRecords": 220},
        "startTime": "2016-03-01",
        "tradeCategory": [
          {"tradeType": 10001, "tradeTypeDesc": "充值"},
          {"tradeType": 10007, "tradeTypeDesc": "提现"},
          {"tradeType": 10004, "tradeTypeDesc": "出借"},
          {"tradeType": 10006, "tradeTypeDesc": "本金"},
          {"tradeType": 10005, "tradeTypeDesc": "利息"},
          {"tradeType": 10003, "tradeTypeDesc": "奖励"},
          {"tradeType": 10002, "tradeTypeDesc": "手续费"},
          {"tradeType": 10012, "tradeTypeDesc": "补偿金"},
          {"tradeType": 10009, "tradeTypeDesc": "债权转让"},
          {"tradeType": 10000, "tradeTypeDesc": "其他"}
        ],
        "tradingType": "0"
      },
      "message": "success"
    };

    return TradeDetailTotalModel.fromJson(data);
  }
}
