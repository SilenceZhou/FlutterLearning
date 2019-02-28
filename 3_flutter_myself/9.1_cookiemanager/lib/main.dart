import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'services.dart';
import 'dart:io';
import 'common_tools.dart';
import 'package:cookie_jar/cookie_jar.dart'; // 研究

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final Widget child;
  MyApp({Key key, this.child}) : super(key: key);
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _account_editingController =
      TextEditingController();
  final TextEditingController _pwd_editingController = TextEditingController();

  dynamic _cookieString;

  @override
  void initState() {
    // TODO: implement initState
    _account_editingController.text = "17748545625";
    _pwd_editingController.text = "a123456";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Manager',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cookie Manager'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: _account_editingController,
                  decoration: InputDecoration(hintText: '请输入账号'),
                  cursorColor: Colors.blue[50],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: TextField(
                  controller: _pwd_editingController,
                  decoration: InputDecoration(hintText: '请输入密码'),
                  cursorColor: Colors.blue[50],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: RaisedButton(
                  onPressed: () {
                    _login(
                      _account_editingController.text.toString(),
                      _pwd_editingController.text.toString(),
                    );
                  },
                  child: Text('登录',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: _myIntegralDetail,
                  child: Text('获取积分数据',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 获取我的积分
  void _myIntegralDetail() async {
    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;

    // 第一种这种搭配是有问题的？？？？
    // option.headers = njqheaders;
    // option.headers['cookie'] = cookieString;
    option.headers['cookie'] = _cookieString;
    option.headers['loginSource'] = "IOS";

    Dio dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY 10.1.13.15:8888";
      };
    };

    dio.options.baseUrl = njqbaseUrl;

    Response response = await dio.post(myIntegralDetaiUrl,
        data: {
          "pageSize": "10",
          "currentPage": "1",
        },
        options: option);

    if (response.statusCode == HttpStatus.ok) {
      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n \n===请求url: ${response.request.uri.toString()} \n \n===请求 头:   \n${response.headers} \n \n===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');
    } else {
      print('请求失败');
    }
  }

  /// 登陆
  void _login(String account, String pwd) async {
    print('account = ${account}, pwd = ${pwd}');

    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers = njqheaders;

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        //proxy to my PC(charles)
        return "PROXY 10.1.13.15:8888";
      };
    };

    Response response = await dio.post(loginUrl,
        data: {
          "accountName": account,
          "password": generateMd5(pwd),
        },
        options: option);

    if (response.statusCode == HttpStatus.ok) {
      _parmsCookieAndStore(response);
      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n \n===请求url: ${response.request.uri.toString()} \n \n===请求 头:   \n${response.headers} \n \n===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');
    } else {
      print('请求失败');
    }
  }

  /// 仿照原生进行cookie处理
  void _parmsCookieAndStore(Response response) {
    Set cookie1 = response.headers['Set\-Cookie'].toSet();

    print('11111=======${cookie1}');

    String cookie = response.headers['Set\-Cookie'].toString();
    List<String> cookieList = cookie.split(kCookieHeader);
    cookieList = cookieList.last.toString().split(';');

    List<String> mesessionIDs = List();
    if (cookie.contains(kMYSESSIONID)) {
      mesessionIDs = cookie.split(kMYSESSIONID);
      mesessionIDs = mesessionIDs.last.toString().split(';');
    }

    String mysessionIDString = mesessionIDs.last.toString();
    if (mysessionIDString != null && mysessionIDString.length > 0) {
      cookie =
          "${cookieList.first.toString()};Path=/;HttpOnly;MYSESSIONID=${mesessionIDs.first.toString()};Path=/;HttpOnly;channel=\"IOS\";";
    } else {
      cookie =
          "${cookieList.first.toString()};Path=/;HttpOnly;channel=\"IOS\";";
    }
    cookie = "${kCookieHeader}+${cookie}";
    print('Cookie最终结果============\n${cookie}');
    _cookieString = cookie;

    return;

    /// 后面的用cookiejar来处理cookie待研究
    // List<String> _cookieDict = cookie.split(';');

    // print('1111_cookieDict = ${_cookieDict}');

    // for (var i = 0; i < _cookieDict.length; i++) {
    //   String subStr = _cookieDict[i];
    //   if (subStr.contains('HttpOnly')) {
    //     _cookieDict.remove(subStr);
    //   }
    // }
    // for (var i = 0; i < _cookieDict.length; i++) {
    //   String subStr = _cookieDict[i];
    //   if (subStr.contains('Path=/')) {
    //     _cookieDict.remove(subStr);
    //   }
    // }

    // for (var i = 0; i < _cookieDict.length; i++) {
    //   String subStr = _cookieDict[i];
    //   if (subStr.length <= 0) {
    //     _cookieDict.remove(subStr);
    //   }
    // }

    // print('2222_cookieDict = ${_cookieDict}');

    // // 设置cookielist
    // List<Cookie> tmpCookieList = List();

    // for (var i = 0; i < _cookieDict.length; i++) {
    //   String subStr = _cookieDict[i];
    //   var _cookieKey = subStr.split("=").first;
    //   var _cookieValue = subStr.split("=").last;
    //   print('_cookieKey = ${_cookieKey}, _cookieValue = ${_cookieValue}');
    //   if (_cookieKey.length > 0 && _cookieValue.length > 0) {
    //     tmpCookieList.add(Cookie(_cookieKey, _cookieValue));
    //   }
    // }

    // Uri uri = Uri.parse(cookieUrl);
    // var cj = CookieJar();
    // cj.saveFromResponse(uri, tmpCookieList);
    // List<Cookie> results = cj.loadForRequest(uri);

    // print("1111=========================== ${results}");
  }
}
