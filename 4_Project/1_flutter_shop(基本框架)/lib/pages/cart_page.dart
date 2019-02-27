import 'package:flutter/material.dart'; // Android的风格
import 'package:flutter/cupertino.dart'; //iOS的风格

class CarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Text('购物车'),
      ),
    );
  }
}
