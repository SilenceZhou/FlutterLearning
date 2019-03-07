/*
 * @version: 3.1.4
 * @author: yuhuai
 * @Company: 农金圈
 * @LastEditors: Do not edit
 * @Date: 2019-03-07 15:36:24
 * @LastEditTime: 2019-03-07 16:46:46
 */

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('img 上传 下载'),
      ),
      body: Center(
          child: Column(
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 200,
              child: RaisedButton(
                child: Text('登陆'),
                onPressed: login,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 200,
              child: RaisedButton(
                child: Text('下载'),
                onPressed: loadImg,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: 200,
              child: RaisedButton(
                child: Text('上传'),
                onPressed: upLoadImg,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(),
          )
        ],
      )),
    );
  }

  Future login() {
    print('登陆');
  }

  /**
   * @name: 
   * @param {type} 
   * @return: 
   */
  Future loadImg() {
    print('---------图片上传');

    Dio dio = Dio();
    //dio.post(path).then(onValue)
  }

  Future upLoadImg() {
    print('---------图片下载');
  }
}
