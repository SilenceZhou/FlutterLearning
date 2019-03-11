import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final Widget child;

  SplashPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
