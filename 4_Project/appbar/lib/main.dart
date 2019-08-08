import 'package:flutter/material.dart';
import 'zy_appbar.dart';
import 'second_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // shape: Border(bottom: BorderSide(width: 0.5, color: Colors.blue)),
      //   // brightness: Brightness.light,
      //   titleSpacing: 0.0,
      //   // backgroundColor: Colors.white,
      //   title: Container(
      //     // color: Colors.white,
      //     width: double.infinity, //MediaQuery.of(context).size.width,
      //     height: double.infinity,
      //     alignment: Alignment.center,
      //     child: Text('Material App Bar111'),
      //   ),
      //   elevation: 0.5,
      // ),
      appBar: ZYAppBar(
        // brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        isShowLeading: false,
        title: Text(
          'HomePage',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        // leading: Text('hello'),
      ),
      body: GestureDetector(
        onTap: () {
          print("==========");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Hello World',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
