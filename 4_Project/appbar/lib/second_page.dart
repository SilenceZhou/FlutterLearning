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
      appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          leading: null,
          backgroundColor: Colors.blue,
          title: Text("Second Page")
          // Container(
          //   color: Colors.red,
          //   width: double.infinity, //MediaQuery.of(context).size.width,
          //   height: double.infinity,
          //   alignment: Alignment.center,
          //   child: Text('Material App Bar111'),
          // ),
          ),

      // appBar: ZYAppBar(
      //   // hasBack: false,
      //   title: Text('Second Page'),
      //   leading: Text('hello'),
      // ),
    );
  }
}
