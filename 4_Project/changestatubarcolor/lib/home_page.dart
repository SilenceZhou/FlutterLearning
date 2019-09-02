import 'package:changestatubarcolor/router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status bar color"),
        brightness: Brightness.dark, // 白
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _item("First AppBar page", () {
              print("------");
              Navigator.pushNamed(context, Router.firstAppBar);
            }),
            _item("First No AppBar page", () {
              Navigator.pushNamed(context, Router.firstNoAppBar);
            }),
            _item("AppBar与body同时设置", () {
              Navigator.pushNamed(context, Router.appBarAndBody);
            }),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, Function callBack) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey[300],
      ))),
      child: ListTile(
        title: Text(title),
        onTap: callBack,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
