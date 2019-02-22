import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http; //导入前需要配置
import 'package:dio/dio.dart';
import 'service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //隐藏debug标签
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('network demo'),
        ),
        body: Center(
          child: GestureDetector(
            child: Container(
                child: Text(
                  '发起网络请求',
                  style: TextStyle(color: Colors.lightBlue),
                ),
                height: 100,
                width: 200,
                color: Colors.yellowAccent,
                //居中设置
                alignment: Alignment.center),
            onTap: () {
              // 发起网络请求
              print('模拟发起网络请求');
              loadData_dio();
            },
          ),
        ),
      ),
    );
  }

  loadData_sys() async {
    //使用系统的
    print('loadData_sys');

    var httpClient = new HttpClient();

    var params = Map<String, String>();

    // uri方法1
    Uri uri = Uri(
        scheme: 'https',
        host: 'appbg.lcfarm.com',
        path: '/api/product/list/noviceProductList.htm');

    // uri方法2
    // Uri uri = Uri.https(
    //     'appbg.lcfarm.com', '/api/product/list/noviceProductList.htm');

    // uri方法3
    // Uri uri = Uri.parse(
    //     'https://appbg.lcfarm.com/api/product/list/noviceProductList.htm');
    var request = await httpClient.getUrl(uri);

    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    request.headers.add("loginSource", "IOS");
    request.headers.add("useVersion", "3.1.0");
    request.headers.add("isEncoded", "1");
    request.headers.add("bundleId", "com.nongfadai.iospro");

    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      print('--------------请求成功');
      print(response.headers);

      // var responseBody = await response.transform(Utf8Decoder()).join();
      // print('1111请求成功,输入如下:\n $responseBody');
      // print('--------------');
      // Map data = jsonDecode(responseBody);
      // print('222请求成功,输入如下:\n $data');

    } else {
      print(response);
      print('\n\n\n11111==请求失败${response.statusCode}');
    }
  }

  // 第二种方法： 库http
  // get
  void loadData_io_get() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://appbg.lcfarm.com/api/product/list/noviceProductList.htm');

    http.Response response = await client.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    } else {
      print('\n\n\n11111==请求失败${response.statusCode}');
    }
  }

  void loadData_io_get2() async {
    var uri = Uri.parse(
        'https://appbg.lcfarm.com/api/product/list/noviceProductList.htm');
    http.Client().get(uri).then((http.Response response) {
      print('简便方法loadData_io_get2');
      if (response.statusCode == HttpStatus.ok) {
        print(response.body);
      }
    });
  }

  // Post
  void loadData_io_post() async {
    var params = Map<String, String>();
    params["currentPage"] = "2";

    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    // headers['deviceID'] = 'IOS';
    // headers['Cookie'] = 'IOS';

    // http.Client().head('https://appbg.lcfarm.com/api/product/list/regularProductList.htm', headers: headers);

    http.Client()
        // .head(
        //     'https://appbg.lcfarm.com/api/product/list/regularProductList.htm',
        //     headers: headers)
        .post(
            'https://appbg.lcfarm.com/api/product/list/regularProductList.htm',
            body: params)
        .then((http.Response response) {
      print('loadData_io_post');
      if (response.statusCode == HttpStatus.ok) {
        print('请求成功');
        print(response.body);
        print('请求头如下');
        print(response.headers);
      }
    });
  }

  // 方法3： dio
  void loadData_dio() async {
    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';

    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    dio.options.headers.addAll(headers);

    Response response;

    var formData = Map<String, String>(); //{'adType': 'homeBanner'};
    formData["adType"] = "homeBanner";
    response = await dio.post(adUrl, data: formData);

    if (response.statusCode == HttpStatus.ok) {
      print(response.headers);
      print(response.data);
    }
  }
}
