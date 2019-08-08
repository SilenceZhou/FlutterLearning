import 'package:flutter/material.dart';
import 'lcfarm_alert_dialog.dart';
import 'message_dialog.dart';
import 'tips_confirm_dialog.dart';
import 'first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: FirstPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildButton(
    String text,
    Function onPressed, {
    Color color = Colors.white,
  }) {
    return FlatButton(
      color: color,
      child: Text(text),
      onPressed: onPressed,
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildButton("返回1", () => Navigator.of(context).pop(1)),
              buildButton("返回2", () => Navigator.pop(context, 2)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dailog'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buildButton("显示一个固定的dialog", _showDialog),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return TipsConfirmDialog(
                        message: "我是内容我是内容我是内容我是内容我是内容我是内容我是内",
                        onCancelListener: () {
                          Navigator.pop(context); //关闭对话框
                        },
                        onConfirmListener: () {},
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Text('TipsConfirmDialog'),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return LCAlertDialog(
                        title: "温馨提示",
                        message: "我是内容我是内容我是内容我是内容我是内容我是内容我",
                        barrierDismissible: true,
                        // isHasClose: true,
                        onCloseEvent: () {
                          print("关闭对话框");
                          Navigator.pop(context); //关闭对话框
                        },
                        leftButtonText: "取消",
                        leftButtonTap: () {
                          Navigator.pop(context);
                        },
                        rightButtonText: "确认",
                        rightButtonTap: () {
                          Navigator.pop(context);
                        },
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Text('LCAlertDialog'),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return MessageDialog(
                        title: "温馨提示",
                        // message: "我是内容我是",
                        onCloseEvent: () {
                          print("关闭对话框");
                          Navigator.pop(context); //关闭对话框
                        },
                        negativeText: "取消",
                        positiveText: "确认",
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Text('MessageDialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
