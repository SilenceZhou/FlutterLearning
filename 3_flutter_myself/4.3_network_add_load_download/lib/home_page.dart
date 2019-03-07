import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http; //导入前需要配置
import 'package:dio/dio.dart';
import 'service.dart';

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> _list;

  @override
  void initState() {
    super.initState();
    _list = List();
    _list
      ..add('一、flutter系统自带 HttpClient')
      ..add('1.1. HttpClient - Get')
      ..add('1.2. HttpClient - Post')
      ..add('二、网络请求第三方库 http')
      ..add('2.1. http - Get')
      ..add('2.2. http - Get-convenience')
      ..add('2.3. http - Post')
      ..add('2.4. http - Post-convenience')
      ..add('三、网络请求第三方库 Dio')
      ..add('3.1. Dio - Get')
      ..add('3.2. Dio - Post-dioOfOptionsSetting')
      ..add('3.3. Dio - Post-newOptionSetting')
      ..add('3.4. Dio - uploadImge')
      ..add('3.5. Dio - download');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Net collection demo',
      theme: ThemeData(primaryColor: Colors.lightBlueAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Net collection demo'),
        ),
        body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0 || index == 3 || index == 8) {
                } else if (index == 1) {
                  loadData_sys_get();
                } else if (index == 2) {
                  loadData_sys_post();
                } else if (index == 4) {
                  loadData_http_get();
                } else if (index == 5) {
                  loadData_http_get_convenience();
                } else if (index == 6) {
                  loadData_http_post();
                } else if (index == 7) {
                  loadData_http_post_convenience();
                } else if (index == 9) {
                  loadData_dio_get();
                } else if (index == 10) {
                  loadData_dio_dioOfOptionsSetting();
                } else if (index == 11) {
                  loadData_dio_newOptionSetting();
                }
              },
              child: Container(
                child: ListTile(
                  title: Text(
                    '${_list[index]}',
                  ),
                ),
                color: (index == 0 || index == 3 || index == 8)
                    ? Colors.black12
                    : Colors.white,
                height: (index == 0 || index == 3 || index == 8) ? 55.0 : 65.0,
                alignment: Alignment.centerLeft,
              ),
            );
          },
        ),
      ),
    );
  }

  /// ==============================================
  ///   一、Flutter系统自带的 HttpClient
  /// ==============================================
  // 1.1 HttpClient - get （疑问？queryParameters仅仅用在get请求吗）
  void loadData_sys_get() async {
    print('------loadData_sys_get--------');

    var httpClient = new HttpClient();
    var params = Map<String, String>();

    // uri方法1
    Uri uri =
        Uri(scheme: 'https', host: 'appbg.lcfarm.com', path: homeNoviceListUrl);

    // uri方法2
    // Uri uri = Uri.https(
    //     'appbg.lcfarm.com', homeNoviceListUrl);

    // uri方法3
    // Uri uri = Uri.parse(njqbaseUrl + homeNoviceListUrl);

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
    var responseBody = await response.transform(Utf8Decoder()).join();

    if (response.statusCode == HttpStatus.ok) {
      print('请求头：${response.headers}');

      print('111请求成功代发数据为:\n $responseBody');
      print('--------------');
      Map data = jsonDecode(responseBody);
      print('222请求成功代发数据为:\n $data');
    } else {
      print('\n\n\n11111==请求失败${response.statusCode}');
    }
  }

  // 1.2 HttpClient - post
  void loadData_sys_post() async {
    print('------loadData_sys_post--------');

    HttpClient httpClient = new HttpClient();

    // queryParameters get请求的查询参数(适用于get请求？？？是吗？？？)
    // Uri uri = Uri(
    //     scheme: "https", host: "appbg.lcfarm.com", path: homeRegularListUrl);
    // HttpClientRequest request = await httpClient.postUrl(uri);

    var url = njqbaseUrl + homeRegularListUrl;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

    // 设置请求头
    request.headers.set("loginSource", "IOS");
    request.headers.set("useVersion", "3.1.0");
    request.headers.set("isEncoded", "1");
    request.headers.set("bundleId", "com.nongfadai.iospro");
    // Content-Type大小写都ok
    request.headers.set('content-type', 'application/json');

    /// 添加请求体
    /// https://stackoverflow.com/questions/50278258/http-post-with-json-on-body-flutter-dart/50295533
    Map jsonMap = {'currentPage': '1'};
    request.add(utf8.encode(json.encode(jsonMap)));

    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    if (response.statusCode == HttpStatus.ok) {
      print('请求成功');
      print(response.headers);
      print(responseBody);
    }
  }

  /// ==============================================
  ///   二、请求第三方库 http
  /// ==============================================
  // 1.1. http - get1
  void loadData_http_get() async {
    print('------loadData_http_get--------');

    var client = http.Client();

    var uri = Uri.parse(njqbaseUrl + homeNoviceListUrl);

    http.Response response = await client.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    } else {
      print('请求失败 code 码为${response.statusCode}');
    }
  }

  // 1.2. http - get简便方法（链式编程）
  void loadData_http_get_convenience() async {
    print('------简便方法loadData_http_get_convenience--------');

    var uri = Uri.parse(njqbaseUrl + homeNoviceListUrl);

    http.Client().get(uri).then((http.Response response) {
      if (response.statusCode == HttpStatus.ok) {
        print(response.body);
      } else {
        print('请求失败 code 码为${response.statusCode}');
      }
    });
  }

  // 1.3. http - post
  void loadData_http_post() async {
    print('------ loadData_http_post --------');

    var headers = Map<String, String>();
    headers["loginSource"] = "IOS";
    headers["useVersion"] = "3.1.0";
    headers["isEncoded"] = "1";
    headers["bundleId"] = "com.nongfadai.iospro";
    headers["loginSource"] = "IOS";
    headers["Content\-Type"] = "application/json";

    Map params = {'currentPage': '1'};
    // 嵌套两层都可以，但是具体哪个好还有待确认？？？？
    var jsonParams = utf8.encode(json.encode(params));
    // var jsonParams = json.encode(params);

    var httpClient = http.Client();

    var uri = Uri.parse(njqbaseUrl + homeNoviceListUrl);

    http.Response response =
        await httpClient.post(uri, body: jsonParams, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
    } else {
      print('请求失败 code 码���${response.statusCode}');
    }
  }

  // 1.4. http - Post简便方法（链式编程）
  void loadData_http_post_convenience() async {
    print('------ loadData_http_post --------');

    var headers = Map<String, String>();
    headers["loginSource"] = "IOS";
    headers["useVersion"] = "3.1.0";
    headers["isEncoded"] = "1";
    headers["bundleId"] = "com.nongfadai.iospro";
    headers["loginSource"] = "IOS";
    headers["Content\-Type"] = "application/json";

    Map params = {'currentPage': '1'};
    // 嵌套两层都可以，但是具体哪个好还有待确认？？？？
    var jsonParams = utf8.encode(json.encode(params));
    // var jsonParams = json.encode(params);

    var httpClient = http.Client();

    var url = njqbaseUrl + homeRegularListUrl;

    httpClient.post(url, body: jsonParams, headers: headers).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }).whenComplete(httpClient.close);
  }

  /// ==============================================
  ///   三、网络请求第三方库 Dio
  /// ==============================================
  // 3.1 dio的get请求（baseUrl都是在dio.option.baseUrl设置的）
  // 请求头可以在dio.option上设置，也可以在新建的option上设置,新建option是可选的
  void loadData_dio_get() async {
    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Dio dio = Dio();
    dio.options.headers.addAll(headers);
    dio.options.baseUrl = njqbaseUrl;

    Response response = await dio.get(homeNoviceListUrl);

    if (response.statusCode == HttpStatus.ok) {
      print(response.headers);
      print(response.data);
    }
  }

  // dio - 方式一（baseUrl都是在dio.option.baseUrl设置的）
  // 直接在 dio.options设置除methods以外的 请求头参数
  void loadData_dio_dioOfOptionsSetting() async {
    debugPrint(
        ' \n post请求 ======================= 开始请求 =======================\n');
    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;
    dio.options.connectTimeout = 60000;
    dio.options.receiveTimeout = 60000;
    dio.options.headers.addAll(headers);
    dio.options.method = 'post';

    Options option = Options(method: 'post');
    // Response response = await dio.request(homeRegularListUrl,
    //     data: {"currentPage": "1"}, options: option);

    Response response = await dio.post(homeRegularListUrl,
        data: {"currentPage": "1"}, options: option);

    if (response.statusCode == HttpStatus.ok) {
      debugPrint('请求参数： ${response.request.queryParameters}');
      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n \n===请求求url: ${response.request.uri.toString()} \n \n===请求 ���:   \n${response.headers} \n \n===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');
    } else {
      print('请求失败');
    }
  }

  // dio - 方式二（baseUrl都是在dio.option.baseUrl设置的）
  // 在新建的option上设置请求头参数
  void loadData_dio_newOptionSetting() async {
    debugPrint(' \n======================= 开始请求 =======================\n');
    var headers = Map<String, String>();
    headers['loginSource'] = 'IOS';
    headers['useVersion'] = '3.1.0';
    headers['isEncoded'] = '1';
    headers['bundleId'] = 'com.nongfadai.iospro';
    headers['Content-Type'] = 'application/json';

    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers.addAll(headers);

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;

    Response response = await dio.post(homeRegularListUrl,
        data: {"currentPage": 1}, options: option);
    // Response response = await dio.request(homeRegularListUrl,
    // data: {"currentPage": 1}, options: option);

    if (response.statusCode == HttpStatus.ok) {
      debugPrint('请求参数： ${response.request.queryParameters}');
      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n \n===请求url: ${response.request.uri.toString()} \n \n===请求 头:   \n${response.headers} \n \n===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');
    } else {
      print('请求失败');
    }
  }
}
