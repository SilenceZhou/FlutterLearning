import 'package:flutter/material.dart';
import 'phone_input_page.dart';
import 'verify_code_input_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'input demo',
      home: HomePage(),
      routes: {
        "/phoneinput": (BuildContext context) => PhoneInputsPage(),
        "/verifycodeinput": (BuildContext context) => VerifyCodeInputsPage(),
      },
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
        title: Text("Input Demo"),
      ),
      body: ListView(
        children: <Widget>[
          _item("3-4-4 phone input", () {
            Navigator.pushNamed(context, "/phoneinput");
          }),
          _item("verify code input", () {
            Navigator.pushNamed(context, "/verifycodeinput");
          }),
        ],
      ),
    );
  }

  Widget _item(String text, Function callBack) {
    return ListTile(
      title: Text(text),
      onTap: callBack,
    );
  }
}
