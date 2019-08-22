import 'package:flutter/material.dart';
import 'lcfarm_float_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("输入框"),
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(height: 100),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: LcfarmFloatInput(
                          label: '请输入手机号',
                          enterCallback: (val) {
                            print("回调数据 ${val}");
                          },
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                        ),
                      ),
                      Container(height: 10),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: LcfarmFloatInput(
                          label: '请输入密码',
                          enterCallback: (val) {
                            print("回调数据 ${val}");
                          },
                          keyboardType: TextInputType.text,
                          maxLength: 20,
                          secureTextEntry: true,
                          isClearCiphertext: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
