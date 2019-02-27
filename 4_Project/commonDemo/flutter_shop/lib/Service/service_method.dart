import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

/// 获取首页主题内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据.....');
    Response response;
    Options option = Options(method: 'post');
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = ContentType.parse("application/json");
    dio.options.headers = {"loginSource": "IOS"};

    var formData = {
      "adType": "homeBanner,homeAd,homeBottom,findBanner,findIntegralConsume"
    };
    response = await dio.post(adInfoUrl, data: formData, options: option);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('=====================${e}');
  }
}
