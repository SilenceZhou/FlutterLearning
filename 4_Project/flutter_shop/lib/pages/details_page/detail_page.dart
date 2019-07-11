import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'details_top_area.dart';
import 'details_explain.dart';
import 'details_tabbar.dart';
import '../../routers/application.dart';
import 'details_web.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;
  const DetailPage({this.goodsId});

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Application.router.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 判断为hasData
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: <Widget>[
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailsTabbar(),
                  DetailsWeb(),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中......'),
            );
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
    return '加载完成......';
  }
}
