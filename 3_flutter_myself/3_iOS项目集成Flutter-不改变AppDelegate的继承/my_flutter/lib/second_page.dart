import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Second Page'),
        // ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              //Navigator.of(context).pop();
              SystemNavigator.pop();
            },
            child: Container(
              width: 100,
              height: 100,
              child: Text('返回'),
            ),
          ),
        ),
      ),
    );
  }
}
