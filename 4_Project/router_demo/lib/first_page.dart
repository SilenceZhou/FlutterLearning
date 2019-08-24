import 'package:flutter/material.dart';
import 'router.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void dispose() {
    super.dispose();
    print("FirstPage dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('push second page'),
            onPressed: () {
              Navigator.pushNamed(context, Router.secondPage);
            },
          ),
        ),
      ),
    );
  }
}
