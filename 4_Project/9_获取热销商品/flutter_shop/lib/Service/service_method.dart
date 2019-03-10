import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 调试的时候打开， 不调试的时候注释掉
// (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//     (client) {
//   client.findProxy = (uri) {
//     return "PROXY 192.168.1.101:8888";
//   };
// };

/// 统一网络请求方法
/// 默认的请求contentType为：application/x-www-form-urlencode
/// 默认需要传递全路径
Future request(url, {formData, type}) async {
  try {
    print('${url}开始获取数据.....');
    Response response;
    Options option = Options(method: 'post');
    Dio dio = Dio();
    if (type == 'json') {
      dio.options.baseUrl = baseUrl;
      dio.options.headers = {"loginSource": "IOS"};
      dio.options.contentType = ContentType.parse("application/json");
    } else {
      dio.options.contentType =
          ContentType.parse("application/x-www-form-urlencode");
    }

    if (formData != null) {
      response = await dio.post(url, data: formData, options: option);
    } else {
      response = await dio.post(url, options: option);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('=====================${e}');
  }
}

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

/// 火爆专区
Future getHomePage_hotBel() async {
  // 带有可选参数调用的时候需要带上形参
  return request(hotBel, formData: {"page": 1});
  // try {
  //   print('开始获取火爆专区数据.....');
  //   Response response;
  //   Options option = Options(method: 'post');
  //   Dio dio = Dio();
  //   // dio.options.baseUrl = baseUrl;
  //   dio.options.contentType =
  //       ContentType.parse("application/x-www-form-urlencode");
  //   dio.options.headers = {"loginSource": "IOS"};

  //   // 调试的时候打开， 不调试的时候注释掉
  //   // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //   //     (client) {
  //   //   client.findProxy = (uri) {
  //   //     return "PROXY 192.168.1.101:8888";
  //   //   };
  //   // };

  //   int page = 1;
  //   var formData = {"page": page};
  //   response = await dio.post(hotBel, data: formData, options: option);

  //   if (response.statusCode == 200) {
  //     print('response.data ======== ${response.data}');
  //     return response.data;
  //   } else {
  //     throw Exception('后端接口出现异常');
  //   }
  // } catch (e) {
  //   return print('=====================${e}');
  // }
}
