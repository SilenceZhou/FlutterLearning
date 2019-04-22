import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'adsorptionlistbin.dart';
import 'adsorptionview.dart';

import 'dart:math';

class AdsorptionViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    List<AdsorptionListBin> adsorptionDatas = new List();
    AdsorptionListBin adsorptionData;

    adsorptionData = new AdsorptionListBin("A");
    adsorptionData.isHeader = true;
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("阿杜");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("阿宝");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("艾夫杰尼");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("阿牛");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("安苏羽");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("阿勒长青");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("B");
    adsorptionData.isHeader = true;
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("白小白");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("白羽毛");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("Bridge");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("斑马");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("白一阳");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("白举纲");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("暴林");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("C");
    adsorptionData.isHeader = true;
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈奕迅");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈小春");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("成龙");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈百强");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("迟志强");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("崔健");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈晓东");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈学冬");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("蔡国庆");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈冠希");
    adsorptionDatas.add(adsorptionData);

    adsorptionData = new AdsorptionListBin("陈琳");
    adsorptionDatas.add(adsorptionData);
    return new AdsorptionViewState(adsorptionDatas);
  }
}

///此控件适用于固定高度的ListView
class AdsorptionViewState extends State<AdsorptionViewDemo> {
  AdsorptionViewState(this.adsorptionDatas);

  /// 数据源
  List<AdsorptionListBin> adsorptionDatas;

  /// cell 高度
  double itemHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("吸附布局"),
      ),
      body: new AdsorptionView(
        isEqualHeightItem: true,
        adsorptionDatas: adsorptionDatas,

        /// listView
        generalItemChild: (AdsorptionListBin bin) {
          return new InkWell(
            onTap: () {
              print("build bin ${bin}");
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              child: new Text(
                bin.headerName,
                style: new TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
          );
        },

        /// 头部显示
        headChild: (AdsorptionListBin bin) {
          print("build head Child");

          /// 如果点击头部需要别的相应 需在外面抱一层点击
          // return new InkWell(
          //   onTap: () {
          //     print('bin = $bin');
          //   },
          //   child: Container(
          //     color: Colors.grey,
          //     alignment: Alignment.centerLeft,
          //     padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
          //     child: new Text(
          //       bin.headerName,
          //       style: new TextStyle(fontSize: 20.0, color: Colors.black),
          //     ),
          //   ),
          // );

          /// 点击头部会把该组元素全部展示出来
          return Container(
            // color: ExtensionColor.random(),
            color: Colors.grey,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
            child: new Text(
              bin.headerName,
              style: new TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}

/// 随机色
class ExtensionColor {
  static final Random _random = new Random();

  /// Returns a random color.
  static Color random() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}
