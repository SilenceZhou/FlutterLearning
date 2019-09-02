import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 暂时没用到
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // @override
  // void initState() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  //   super.initState();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Second Page"),
      //   brightness: Brightness.dark,
      // ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          child: Center(
            child: Text("Second Page"),
          ),
        ),
      ),
    );
  }
}
