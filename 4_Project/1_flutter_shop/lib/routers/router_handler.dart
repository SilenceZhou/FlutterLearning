import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';
import '../pages/details_page/detail_page.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('detailHnader 商品id: $goodsId');
  return DetailPage(goodsId: goodsId);
});
