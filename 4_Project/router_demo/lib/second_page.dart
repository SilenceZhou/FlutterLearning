import 'package:flutter/material.dart';
import 'router.dart';
import 'first_page.dart';
import 'three_page.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void dispose() {
    super.dispose();
    print("SecondPage dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Column(
        children: <Widget>[
          /// pushNamed
          Container(height: 100),
          Text("命名push"),
          RaisedButton(
            child: Text('pushName => three page'),
            onPressed: () {
              Navigator.pushNamed(context, Router.threePage);
            },
          ),

          /// pushReplacementNamed: 替换当前页面
          Container(height: 10),
          RaisedButton(
            child: Text('pushReplacementNamed => three page'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Router.threePage);
            },
          ),

          /// pushNamedAndRemoveUntil
          Container(height: 10),
          RaisedButton(
            child: Text('pushNamedAndRemoveUntil => three page'),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, Router.threePage,
                  ModalRoute.withName(Router.firstPage));
            },
          ),

          /// 简单push
          /// pushReplacement: 替换当前页面
          Container(height: 10),
          Text("简单push"),
          RaisedButton(
            child: Text('pushReplacement => three page'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ThreePage(),
                ),
              );
            },
          ),

          /// pushAndRemoveUntil: 移除(predicate)前面所有元素
          Container(height: 10),
          RaisedButton(
            child: Text('pushAndRemoveUntil => three page'),
            onPressed: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => ThreePage()),
              //     ModalRoute.withName(Router.secondPage));

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ThreePage()),
                  (Route<dynamic> route) => false);

              /// pushAndRemoveUntil 最后一个参数：
              /// 1、(Route route) => false 将确保删除推送路线之前的所有路线。 这时候将打开一个新的页面
              /// 2、最后一个参数ModalRoute.withName(Router.secondPage) 中的 page 和 目标页面 之间的页面去掉， 但是如过最后一个页面是第一个页面，则会和1效果一样
            },
          ),
        ],
      ),
    );
  }
}
