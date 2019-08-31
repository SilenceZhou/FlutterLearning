import 'package:changestatubarcolor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPageAppBar extends StatefulWidget {
  @override
  _FirstPageAppBarState createState() => _FirstPageAppBarState();
}

class _FirstPageAppBarState extends State<FirstPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First page AppBar"),
        brightness: Brightness.dark, // 白
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Text("First page AppBar"),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Router.appBarToAppBar);
                },
                child: Text("AppBarPage->AppBarPage"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Router.appBarToNoAppBar);
                },
                child: Text("AppBarPage->No AppBarPage"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
