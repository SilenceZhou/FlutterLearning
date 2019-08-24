import 'package:flutter/material.dart';
import 'event_manager.dart';

class SmsCodeInput extends StatefulWidget {
  @override
  _SmsCodeInputState createState() => _SmsCodeInputState();
}

class _SmsCodeInputState extends State<SmsCodeInput> {
  String msg = "默认数据";
  @override
  void initState() {
    super.initState();
    EventManager().on<FatherToSon>().listen((event) {
      print("Father to son");

      print(event.message);
      setState(() {
        msg = event.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 200,
            child: Center(
              child: Text(msg),
            ),
          ),
          RaisedButton(
            child: Text("Son to Father"),
            onPressed: () {
              EventManager().post(SonToFather("儿子传递数据给爸爸"));
            },
          )
        ],
      ),
    );
  }
}
