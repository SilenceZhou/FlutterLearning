import 'package:changestatubarcolor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarAndBody extends StatefulWidget {
  @override
  _AppBarAndBodyState createState() => _AppBarAndBodyState();
}

class _AppBarAndBodyState extends State<AppBarAndBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App bar body next"),
        brightness: Brightness.light, // 黑
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light, // 白
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 200),
              Text("App bar body next"),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, Router.appBarBodyToAppBarBodyNext);
                },
                child: Text("AppBarAndBody => AppBarAndBodyNextPage"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
