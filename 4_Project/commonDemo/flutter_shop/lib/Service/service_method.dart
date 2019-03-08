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

    // 调试的时候打开， 不调试的时候注释掉
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.1.101:8888";
    //   };
    // };

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

/// 火爆专区
Future getHomePage_hotBel() async {
  try {
    print('开始获取火爆专区数据.....');
    Response response;
    Options option = Options(method: 'post');
    Dio dio = Dio();
    // dio.options.baseUrl = baseUrl;
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencode");
    dio.options.headers = {"loginSource": "IOS"};

    // 调试的时候打开， 不调试的时候注释掉
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.1.101:8888";
    //   };
    // };

    int page = 1;
    var formData = {"page": page};
    response = await dio.post(hotBel, data: formData, options: option);

    if (response.statusCode == 200) {
      print('response.data ======== ${response.data}');
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('=====================${e}');
  }
}
