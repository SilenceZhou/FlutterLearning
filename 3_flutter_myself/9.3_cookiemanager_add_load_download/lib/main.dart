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
    /// 注意获取图片需要权限设置(iOS/Android项目里面自行设置一下)
    print('------从相册获取图片');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      print('相册------获取图片成功');
      _image = image;
    });
  }

  File _image2;
  Future _getImage2() async {
    /// 调用相机获取图片
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 240.0,
      maxWidth: 240.0,
    );
    setState(() {
      print('相机------获取图片成功');
      _image2 = image;
    });
  }

  /// 上传图片
  void _uploadImg() async {
    print('---------------开始上传图片');
    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers = {
      "loginSource": "IOS",
      "cookie": cookieString,
      "Content-Type": "multipart/form-data" //图片上传一定是这个type类型
    };

    Dio dio = Dio();
    dio.options.baseUrl = njqbaseUrl;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return "PROXY 10.1.13.15:8888";
      };
    };

    /// 第一种
    /// 参考链接1：https://medium.com/@nitishk72/flutter-uploading-image-to-server-aec76876b9e1
    /// 参考链接2：https://medium.com/@samuelomole/upload-images-to-a-rest-api-with-flutter-7ec1c447ff0e
    //String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;
    //String base64Image1 = base64Encode(_image2.readAsBytesSync());
    String fileName1 = _image2.path.split("/").last;

    FormData formData = new FormData.from({
      "reason": "原银行卡遗失或注销",
      "idCardPositive":
          UploadFileInfo.fromBytes(_image.readAsBytesSync(), fileName),
      "idCardNegative":
          UploadFileInfo.fromBytes(_image2.readAsBytesSync(), fileName1)
    });

    /// 第二种 ---直接用map作为data获取不成功
    Map<String, dynamic> data = {
      "reason": "原银行卡遗失或注销",
      "idCardPositive": _image.readAsBytesSync(),
      "idCardNegative": _image2.readAsBytesSync(),
    };

    /// 第三种方法：绝对路径OK
    FormData formData3 = FormData.from({
      "reason": "上传图片原因",
      "idCardPositive": UploadFileInfo(
          File(
              "/Users/zhouyun/Desktop/FlutterLearning/3_flutter_myself/9.3_cookiemanager_add_load_download/images/111.png"),
          "111.png"),
      "idCardNegative": UploadFileInfo(
          File(
              "/Users/zhouyun/Desktop/FlutterLearning/3_flutter_myself/9.3_cookiemanager_add_load_download/images/2222.png"),
          "2222.png")
    });

    /// 第四种：相对路径不行 ---- 已经给作者提issue
    FormData formData4 = FormData.from({
      "reason": "上传图片原因",
      "idCardPositive": UploadFileInfo(File("../images/111.png"), "111.png"),
      "idCardNegative": UploadFileInfo(File("../images/2222.png"), "2222.png")
    });

    Response response = await dio.post(
      newUploadUserChangeCardInfo,
      data: data,
      options: option,
      onSendProgress: (received, total) {
        /// 打印进度
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      },
    );

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
    print('cookieString == ${cookieString}');
    Options option = Options(method: 'post');
    option.connectTimeout = 60000;
    option.receiveTimeout = 60000;
    option.headers = {
      "loginSource": "IOS",
      "cookie": cookieString,
      "Content-Type": "multipart/form-data"
    };

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
