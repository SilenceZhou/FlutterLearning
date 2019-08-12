import 'package:flutter/material.dart';
import 'zy_appbar.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   brightness: Brightness.light,
      //   // automaticallyImplyLeading: false,
      //   titleSpacing: 0.0,
      //   leading: null,
      //   backgroundColor: Colors.white,
      //   title: Text("Second Page"),
      //   // textTheme: TextTheme(),
      //   // Container(
      //   //   color: Colors.red,
      //   //   width: double.infinity, //MediaQuery.of(context).size.width,
      //   //   height: double.infinity,
      //   //   alignment: Alignment.center,

      //   //   child: Text('Material App Bar111'),
      //   // ),
      // ),
      appBar: ZYAppBar(
        title: Text('SecondPage'),
        statusBarStyle: ZYStatusBarStyle.dark,
        // leading: Text('hello'),
        // isShowLeading: false,
        // leadingCallBack: _leadingCallBack,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("Second Page"),
        ),
      ),
    );
  }

  void _leadingCallBack() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                            )),
                        // color: Colors.white,
                        width: MediaQuery.of(context).size.width - 80,
                        height: 100,
                        child: Center(
                          child: Text("左边返回按钮被定制"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
