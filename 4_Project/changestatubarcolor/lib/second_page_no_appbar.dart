import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPageNoAppBar extends StatefulWidget {
  @override
  _SecondPageNoAppBarState createState() => _SecondPageNoAppBarState();
}

class _SecondPageNoAppBarState extends State<SecondPageNoAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          child: Center(
            child: Text("Second page No AppBar"),
          ),
        ),
      ),
    );
  }
}
