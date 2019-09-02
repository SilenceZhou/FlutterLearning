import 'package:changestatubarcolor/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPageNoAppBar extends StatefulWidget {
  @override
  _FirstPageNoAppBarState createState() => _FirstPageNoAppBarState();
}

class _FirstPageNoAppBarState extends State<FirstPageNoAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Text("First No AppBar Page"),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Router.noAppBarToAppBar);
                  },
                  child: Text("NoAppBarPage->AppBarPage"),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Router.noAppBarToNoAppBar);
                  },
                  child: Text("NoAppBarPage->NoAppBarPage"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
