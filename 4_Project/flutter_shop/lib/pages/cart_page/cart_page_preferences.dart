import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: _add,
            child: Text('新增'),
          ),
          RaisedButton(
            onPressed: _clear,
            child: Text('清空'),
          ),
        ],
      ),
    );
  }

  /// 增加 设值
  void _add() async {
    print('hello');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmp = '我最坏';
    testList.add(tmp);
    prefs.setStringList('testList', testList);
    _show();
  }

  /// 查询
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('testList') != null) {
      setState(() {
        testList = prefs.getStringList('testList');
      });
    }
  }

  /// 删除
  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// 删除所有的
    //    prefs.clear();

    /// 删除某个关联的key对应的值
    prefs.remove('testList');
    setState(() {
      testList = [];
    });
  }
}
