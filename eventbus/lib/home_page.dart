import 'package:eventbus/event_manager.dart';
import 'package:eventbus/sms_code_input.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String msg = "默认数据";
  @override
  void initState() {
    super.initState();
    EventManager().on<SonToFather>().listen((event) {
      print("儿子传递过来的数据 = ${event.message}");

      setState(() {
        msg = event.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event bus data transition"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Text(msg),
          ),
          Container(
            height: 200,
            width: 300,
            child: RaisedButton(
              child: Text("Father send data son"),
              onPressed: () {
                EventManager().post(FatherToSon("father to son data"));
              },
            ),
          ),
          SmsCodeInput(),
        ],
      ),
    );
  }
}
