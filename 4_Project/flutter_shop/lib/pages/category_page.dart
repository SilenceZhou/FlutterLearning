import 'package:flutter/material.dart';

import 'dart:convert';
import '../service/service_method.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Center(
        child: Text('分类'),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory', null).then((val) {
      var data = json.decode(val.toString());
      print(data);
    });
  }
}
