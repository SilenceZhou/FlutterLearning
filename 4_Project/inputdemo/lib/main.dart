import 'package:flutter/material.dart';
import 'phone_space_input.dart';
import 'phone_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print("应该收起键盘");
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  padding: EdgeInsets.only(left: 30, right: 30),
                ),
                Container(
                  color: Colors.white,
                  child: PhoneSpaceInput(),
                  padding: EdgeInsets.only(left: 30, right: 30),
                ),
                Container(
                  color: Colors.white,
                  child: PhoneInput(),
                  padding: EdgeInsets.only(left: 30, right: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
