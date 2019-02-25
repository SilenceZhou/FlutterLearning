import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';

// void main() => runApp(_widgetForRoute(ui.window.defaultRouteName));

void main(List<String> args) {
  var routUrl = ui.window.defaultRouteName;
  print('--------${routUrl}');
  runApp(_widgetForRoute(routUrl.length > 1 ? routUrl : 'myApp'));
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
      return new MyApp();
    case 'home':
      return new HomePage();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

class MyApp extends StatelessWidget {
  Widget _home(BuildContext context) {
    return new MyHomePage(title: 'Flutter Demo Home Page');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => new HomePage(),
      },
      home: _home(context),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 创建一个给native的channel (类似iOS的通知）
  static const methodChannel =
      const MethodChannel('kIosFlutterExchangeDataChannelKey');

  void initState() {
    super.initState();
    //_iOSPushToVC2();
  }

  _iOSPushToVC() async {
    await methodChannel.invokeMethod('iOSFlutter', '参数');
  }

  _iOSPushToVC1() async {
    Map<String, dynamic> map = {
      "code": "200",
      "data": [1, 2, 3]
    };
    await methodChannel.invokeMethod('iOSFlutter1', map);
  }

  _iOSPushToVC2() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('iOSFlutter2');
    } on PlatformException {
      // PlatformException的值
      // [MethodCodec]，如果收到的结果包络表示错误，则抛出[PlatformException]。
      // [MethodChannel.invokeMethod]，使用[PlatformException]完成返回的未来，如果调用平台插件方法会导致错误信封。
      // [EventChannel.receiveBroadcastStream]，每当从平台插件收到的事件被包装在错误信封中时，它会将[PlatformException]作为错误事件发出。

      result = "error";
    }
    if (result is String) {
      print(result);
      // sheet 提示
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new Container(
              child: new Center(
                child: new Text(
                  result,
                  style: new TextStyle(color: Colors.brown),
                  textAlign: TextAlign.center,
                ),
              ),
              height: 40.0,
            );
          });
    } else if (result is Map) {
      // 直接打印字典
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
              onPressed: () {
                _iOSPushToVC();
              },
              child: new Text("跳转ios新界面，参数是字符串"),
              color: Colors.blue[50],
            ),
            new FlatButton(
              onPressed: () {
                _iOSPushToVC1();
              },
              child: new Text("传参，参数是map，看log"),
              color: Colors.blue[100],
            ),
            new FlatButton(
              onPressed: () {
                _iOSPushToVC2();
              },
              child: new Text("接收客户端相关内容"),
              color: Colors.blue[100],
            ),
          ],
        ),
      ),
    );
  }
}
