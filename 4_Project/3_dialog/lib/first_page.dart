import 'package:flutter/material.dart';
import 'lcfarm_alert_dialog.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final String _title = "温馨提示";
  String _message =
      "内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容";
  // final String _message = "内容我是内容我";
  final String _leftBtnTitle = "取消";
  final String _rightBtnTitle = "我知道了";

  @override
  void initState() {
    super.initState();

    // _message = "内容我是内容我";
    _message =
        "内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容内容我是内容我是内容我是内容";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LCAlertDialog"),
      ),
      body: ListView(
        children: <Widget>[
          /// 不带关闭按钮
          /// message-btn2
          _item("title-btn2", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    message: _title,
                    leftButtonText: _leftBtnTitle,
                    leftButtonTap: () {
                      Navigator.pop(context);
                    },
                    rightButtonText: _rightBtnTitle,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                  );
                });
          }),

          /// message-btn1
          _item("title-btn", () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    message: _message,
                    rightButtonText: _rightBtnTitle,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                  );
                });
          }),

          /// title-message-btn2
          _item("title-message-btn2", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    title: _title,
                    message: _message,
                    leftButtonText: _leftBtnTitle,
                    leftButtonTap: () {
                      Navigator.pop(context);
                    },
                    rightButtonText: _rightBtnTitle,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                  );
                });
          }),

          /// title-message-btn1
          _item("title-message-btn1", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    title: _title,
                    message: _message,
                    rightButtonText: _rightBtnTitle,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                  );
                });
          }),

          /// 带关闭按钮
          /// title/message-close
          _item("title/message-close", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    isHasClose: true,
                    message: _message,
                  );
                });
          }),

          /// title-message-close
          _item("title/message-close", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    isHasClose: true,
                    title: _title,
                    message: _message,
                  );
                });
          }),

          /// title/message-close-btn1
          _item("title/message-close-btn1", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    barrierDismissible: true,
                    isHasClose: true,
                    message: _message,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                    rightButtonText: _rightBtnTitle,
                  );
                });
          }),

          /// title-message-close-btn1
          _item("title-message-close-btn1", () {
            showDialog(
                context: context,
                builder: (context) {
                  return LCAlertDialog(
                    messageTextAlign: TextAlign.center,
                    barrierDismissible: true,
                    isHasClose: true,
                    title: _title,
                    message: _message,
                    rightButtonTap: () {
                      Navigator.pop(context);
                    },
                    rightButtonText: _rightBtnTitle,
                  );
                });
          }),
        ],
      ),
    );
  }

  Widget _item(String title, Function callBack) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Center(
            child: Text(title),
          ),
          onTap: callBack,
        ),
        Divider(color: Colors.black12, height: 0.5)
      ],
    );
  }
}
