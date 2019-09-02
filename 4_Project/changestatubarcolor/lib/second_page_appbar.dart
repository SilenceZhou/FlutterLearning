import 'package:flutter/material.dart';

class SecondPageAppBar extends StatefulWidget {
  @override
  _SecondPageAppBarState createState() => _SecondPageAppBarState();
}

class _SecondPageAppBarState extends State<SecondPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page AppBar"),
        brightness: Brightness.light, // 黑
      ),
      body: AnnotatedRegion(
        value: Brightness.dark,
        child: Container(
          child: Center(
            child: Text("First page AppBar"),
          ),
        ),
      ),
    );
  }
}
