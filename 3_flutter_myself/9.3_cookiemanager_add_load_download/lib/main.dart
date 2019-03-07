import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'services.dart';
import 'dart:io';
import 'dart:convert';
// import 'package:crypto/crypto.dart';
// import 'package:convert/convert.dart';
import 'common_tools.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:image_picker/image_picker.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    // _account_editingController.text = "17748545625";
    // _pwd_editingController.text = "a123456";
    _account_editingController.text = njqaccount;
    _pwd_editingController.text = njqpwd;
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
                padding: EdgeInsets.symmetric(vertical: 20),
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
                  onPressed: _loadmyIntegralDetail,
                  child: Text('积分数据',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: _getImage,
                  child: Text('选择图片1',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: _getImage2,
                  child: Text('选择图片2',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: _uploadImg,
                  child: Text('上传图片',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  File _image;
  Future _getImage() async {
    print('------查实获取图片');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      print('获取图片成功');
      _image = image;
    });
  }

  File _image2;
  Future _getImage2() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 240.0,
      maxWidth: 240.0,
    );
    setState(() {
      print('获取图片成功');
      _image2 = image;
    });
  }

  void _uploadImg() async {
    print('---------------开始上传图片');
    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers = {"loginSource": "IOS", "cookie": cookieString};
    // option.responseType = ResponseType.plain;

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;

// // /Users/zhouyun/Desktop/FlutterLearning/3_flutter_myself/9.3_cookiemanager_add_load_download/images/11.txt

    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;
    String base64Image1 = base64Encode(_image2.readAsBytesSync());
    String fileName1 = _image2.path.split("/").last;
    print('fileName === ${fileName}, fileName1 === ${fileName1}');

    // FormData formData = new FormData.from({
    //   "reason": "原银行卡遗失或注销",
    //   "idCardPositive": UploadFileInfo(base64Image, fileName),
    //   "idCardNegative": _image2,
    // });

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY 10.1.13.15:8888";
      };
    };

    Response response = await dio.post(newUploadUserChangeCardInfo,
        data: {
          "reason": "原银行卡遗失或注销",
          "idCardPositive": base64Image,
          "idCardNegative": base64Image1,
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

  dynamic cookieString;
  void _loadmyIntegralDetail() async {
    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers = {"loginSource": "IOS", "cookie": cookieString};

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.1.102";
    //   };
    // };

    Response response = await dio.post(myIntegralDetailUrl,
        data: {
          "currentPage": 1,
          "pageSize": 10,
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
      // 仿照原生进行cookie处理 --- 待解决问题
      _parmsCookieAndStore(response);

      debugPrint(
          '-------------------请求成功,请求结果如下:-----------------\n \n===��求url: ${response.request.uri.toString()} \n \n===请求 头:   \n${response.headers} \n \n===请求结果: \n${response.data}\n');
      debugPrint('-------------------请求成功,请求结果打印完毕----------------');
    } else {
      print('请求失败');
    }
  }

  void _parmsCookieAndStore(Response response) {
    Set cookie1 = response.headers['Set\-Cookie'].toSet();

    cookie1.length;
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
          "${cookieList.first.toString()};Path=/;HttpOnly;MYSESSIONID=${mesessionIDs.first.toString()};Path=/;HttpOnly;channel=\"channel=IOS\";";
    } else {
      cookie =
          "${cookieList.first.toString()};Path=/;HttpOnly;channel=\"channel=IOS\";";
    }
    cookie = "${kCookieHeader}+${cookie}";
    cookieString = cookie;

    return;

    // print('Cookie最终结果============\n${cookie}');

    // Uri uri = Uri.parse("https://appbg.lcfarm.com/aa");
    // List<Cookie> tmpCookieList = [Cookie("cookie", "hahah")];

    // print('tmpCookieList === ${tmpCookieList}');
    // // mpCookieList === [cookie=hahah; HttpOnly]

    // // return;
    // var cj = CookieJar();
    // //Save cookies
    // cj.saveFromResponse(uri, tmpCookieList);
    // //Get cookies
    // List<Cookie> results = cj.loadForRequest(uri);

    // print("results ===== ${results}");
    // // results ===== [cookie=hahah; HttpOnly]

    return;
  }
}
