import 'package:flutter/material.dart'; // Android的风格
import 'package:flutter/cupertino.dart'; //iOS的风格

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
      ),
      body: Center(
        child: Text('发现'),
      ),
    );
  }
}
