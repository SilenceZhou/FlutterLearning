import 'package:flutter/material.dart';
import 'phone_space_input.dart';
import 'phone_input.dart';
import 'flutter_masked_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3-4-4 iphone number input',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '3-4-4 iphone number input',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          print("应该收起键盘");
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Tips点击顶部和底部空白处收起键盘:',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                _comparamFlutterOrigin(),
                _paintTextAndCursor(),
                _myself(),
                _regexInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comparamFlutterOrigin() {
    return _innerInput(
      title: "官方Input对比",
      child: TextField(
        style: TextStyle(fontSize: 20, color: Colors.red),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _paintTextAndCursor() {
    return _innerInput(
      title: "绘制文案和光标(使用绘图，获焦绘制过于频繁，不能进行复制粘贴操作)",
      child: PhoneSpaceInput(),
    );
  }

  Widget _myself() {
    return _innerInput(
      title: "直接赋值text(使用空格、位置移动有问题)",
      child: PhoneInput(),
    );
  }

  var controller = new MaskedTextController(mask: '000 0000 0000');
  Widget _regexInput() {
    return _innerInput(
      title: "【推荐】正则表达式(使用空格、最佳选择，但删除空格时光标会跳到最后,获取值的时候需要去掉空格)",
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.red),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _innerInput({String title, Widget child}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          child,
        ],
      ),
    );
  }
}
