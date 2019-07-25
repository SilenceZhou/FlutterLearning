import 'package:flutter/material.dart';
import 'zy_appbar.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   brightness: Brightness.light,
      //   // automaticallyImplyLeading: false,
      //   titleSpacing: 0.0,
      //   leading: null,
      //   backgroundColor: Colors.white,
      //   title: Text("Second Page"),
      //   // textTheme: TextTheme(),
      //   // Container(
      //   //   color: Colors.red,
      //   //   width: double.infinity, //MediaQuery.of(context).size.width,
      //   //   height: double.infinity,
      //   //   alignment: Alignment.center,

      //   //   child: Text('Material App Bar111'),
      //   // ),
      // ),
      appBar: ZYAppBar(
        title: Text('SecondPage'),
        leading: Text('hello'),
        statusBarStyle: ZYStatusBarStyle.dark,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("Second Page"),
        ),
      ),
    );
  }
}
