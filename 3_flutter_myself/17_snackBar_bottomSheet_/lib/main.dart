import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/semantics.dart';

/// 很久不写代码 main 都写错
void main() => runApp(MyApp());

/// main函数下的MyApp只做一个简单的入口，把复杂的都给封装起来
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 这个地方不能使用ScreenUtil因为这个时候还没有控件树
    // 报错： MediaQuery.of() called with a context that does not contain a MediaQuery.
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return MaterialApp(
        title: 'Screenutil Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Screenutil Demo'),
            ),
            body: MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return GestureDetector(
      onTap: () {
        print("我被点击了");
        print('设备的高度:${ScreenUtil.screenHeight}');
        print('设备的宽度:${ScreenUtil.screenWidth}');
        print('设备像素密度: ${ScreenUtil.pixelRatio}');

        /// showBottomSheet 的使用
        // Scaffold.of(context)
        //     .showBottomSheet((BuildContext context) {
        //       return Container(
        //         color: Colors.blueAccent,
        //         width: ScreenUtil.screenWidth,
        //         height: 200,
        //         child: Center(
        //           child: Text('showBottomSheet'),
        //         ),
        //       );
        //     })
        //     .closed
        //     .then((onValue) {
        //       print(onValue);
        //     });

        Scaffold.of(context)
            .showSnackBar(SnackBar(
              content: Container(
                child: Center(
                  child: Text('snackbar 提示'),
                ),
                width: ScreenUtil.getInstance().setWidth(300),
                height: ScreenUtil.getInstance().setHeight(200),
              ),
              action: SnackBarAction(
                onPressed: () {},
                label: '撤销',
                textColor: Colors.redAccent,
              ),
              duration: Duration(seconds: 5),
            ))
            .closed
            .then(
          (SnackBarClosedReason reason) {
            // swip   : 下滑动消失
            // remove : Scaffold.of(context).removeCurrentSnackBar();
            // timeout: 设置了持续时间，到了就会自动消失，默认为4秒
            // action : action: SnackBarAction 不管方法onTap里面怎么写都是action(因为默认就会消失，就算写removeCurrentSnackBar也是action)
            // hiden  : Scaffold.of(context)..hideCurrentSnackBar();
            // dimiss : 待研究
            print('reson : $reason');
          },
        );

        // ScaffoldState.removeCurrentSnackBar
        Future.delayed(Duration(seconds: 1)).then((_) {
          // 如何主动关闭 snackBar
          // Scaffold.of(context).removeCurrentSnackBar();
          // Scaffold.of(context).hideCurrentSnackBar();
          SemanticsAction.dismiss; // 不起作用

          // 主动关闭 showBottomSheet
          // Navigator.of(context).pop();
        });
      },
      child: Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(300),
          height: ScreenUtil.getInstance().setHeight(200),
          color: Colors.brown,
          child: Center(child: Text('我是文案')),
        ),
      ),
    );
  }
}
