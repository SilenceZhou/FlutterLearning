import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';

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
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 判断为hasData
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  Text('$goodsId'),
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
