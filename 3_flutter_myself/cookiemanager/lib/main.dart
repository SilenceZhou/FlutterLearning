import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final Widget child;

  MyApp({Key key, this.child}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Manager',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cookie Manager'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: TextField(
                  controller: _editingController,
                  decoration: InputDecoration(hintText: '请输入账号'),
                  cursorColor: Colors.blue[50],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: TextField(
                  controller: _editingController,
                  decoration: InputDecoration(hintText: '请输入密码'),
                  cursorColor: Colors.blue[50],
                ),
              ),
              Container(
                height: 50,
                width: 150,
                // padding: EdgeInsets.symmetric(vertical: 40),
                child: RaisedButton(
                  onPressed: () {
                    print('用户登录');
                  },
                  child: Text('登录',
                      style: TextStyle(fontSize: 20, color: Colors.black54)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login(String account, String pwd) {}
}
