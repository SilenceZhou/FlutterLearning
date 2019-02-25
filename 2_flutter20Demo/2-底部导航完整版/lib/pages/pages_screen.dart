import 'package:flutter/material.dart';


class PagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pages'),),
      body: Center(
        child: Text('Pages', style:TextStyle(color: Colors.blue)),
      ),
    );
  }
}