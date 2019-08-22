import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'event_manager.dart';
import 'sms_code_input.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String msg = "默认数据";

  @override
  void initState() {
    super.initState();
    EventManager().on<ChildToFatherEvent>().listen((event) {
      print(event.message);
      setState(() {
        msg = event.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(child: Text(msg)),
            height: 100,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: RaisedButton(
              child: Text("Father=>child"),
              onPressed: () {
                EventManager().post(SmsEvent("我是父类传递过来的+$msg"));
              },
            ),
          ),
          SmsCodeInput(),
        ],
      ),
    );
  }
}
