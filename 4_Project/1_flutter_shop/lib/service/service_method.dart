import 'package:dio/dio.dart';
import 'dart:async';
import 'service_url.dart';
import 'dart:io';

Future request(url, formData) async {
  try {
    print('开始获取数据--------');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return Exception('后端抛出异常');
    }
  } catch (e) {
    return print(e);
  }
}

// Future getHomePageContent() async {
//   try {
//     print('开始获数据--------');
//     Response response;
//     Dio dio = new Dio();
//     dio.options.contentType =
//         ContentType.parse('application/x-www-form-urlencoded');
//     var formData = {'lon': '112.0989', 'lat': '35.76189'};
//     response = await dio.post(servicePath['homePageContext'], data: formData);
//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       return Exception('后端抛出异常');
//     }
//   } catch (e) {
//     return print(e);
//   }
// }

// /// 获取火爆专区的商品方法
// Future getHomePageBelowConten() async {
//   try {
//     print('开始获取火爆专区的商品数据--------');
//     Response response;
//     Dio dio = new Dio();
//     dio.options.contentType =
//         ContentType.parse('application/x-www-form-urlencoded');
//     int page = 1;
//     response = await dio.post(servicePath['homePageBelowConten'], data: page);
//     if (response.statusCode == 200) {
//       return response.data;
//     } else {
//       return Exception('后端抛出异常');
//     }
//   } catch (e) {
//     return print(e);
//   }
// }
