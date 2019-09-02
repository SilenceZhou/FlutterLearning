import 'package:event_bus/event_bus.dart';
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
    // EventBus().on<SmsEvent>().listen((event) {
    //   print("11111111111");
    // });
    EventManager().on<SmsEvent>().listen((event) {
      print(event);
      setState(() {
        msg = event.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(color: Colors.red[100]),
      child: Column(
        children: <Widget>[
          Container(
            child: Center(child: Text(msg)),
            height: 100,
          ),
          RaisedButton(
            child: Text("子类=>父类"),
            onPressed: () {
              print("子类=>父类");
              // EventBus().fire(ChildToFatherEvent("child => father"));
              EventManager().post(ChildToFatherEvent("child => father"));
            },
          ),
        ],
      ),
    );
  }
}
