import 'package:flutter/material.dart';
import 'router.dart';
import 'four_page.dart';

class ThreePage extends StatefulWidget {
  @override
  _ThreePageState createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  @override
  void dispose() {
    super.dispose();
    print("ThreePage dispose");
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "ModalRoute.withName(Router.firstPage) : ${ModalRoute.withName(Router.firstPage)}");
    // print(
    //     "ModalRoute.withName(Router.secondPage) : ${ModalRoute.withName(Router.secondPage)}");
    // print(
    //     "ModalRoute.withName(Router.threePage) : ${ModalRoute.withName(Router.threePage)}");

    /// 打印结果
    /// flutter: ModalRoute.withName(Router.secondPage) : Closure: (Route<dynamic>) => bool
    /// flutter: ModalRoute.withName(Router.threePage) : Closure: (Route<dynamic>) => bool
    /// flutter: ModalRoute.withName(Router.threePage) : Closure: (Route<dynamic>) => bool
    return Scaffold(
      appBar: AppBar(
        title: Text('Three page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /// pushNamed
            Container(height: 100),
            Text("命名push"),
            RaisedButton(
              child: Text('pushName => four page'),
              onPressed: () {
                Navigator.pushNamed(context, Router.fourPage);
              },
            ),

            /// pushReplacementNamed: 替换当前页面
            Container(height: 10),
            RaisedButton(
              child: Text('pushReplacementNamed => four page'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Router.fourPage);
              },
            ),

            /// pushNamedAndRemoveUntil 参考： pushAndRemoveUntil
            Container(height: 10),
            RaisedButton(
              child: Text('pushNamedAndRemoveUntil => four page'),
              onPressed: () {
                // /// 移除所有 然后push
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Router.fourPage,
                //   (Route<dynamic> route) => false,
                // );

                // /// 直接push
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Router.fourPage,
                //   (Route<dynamic> route) => true,
                // );

                // /// 移除所有 然后push
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Router.fourPage,
                //   ModalRoute.withName(Router.firstPage),
                // );

                // /// 移除secondPage - fourPage之间的页面  === pushReplacementNamed
                // Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   Router.fourPage,
                //   ModalRoute.withName(Router.secondPage),
                // );

                /// 移除 根元素 与 fourPage之间的页面
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Router.fourPage,
                  ModalRoute.withName("/"),
                );
              },
            ),

            /// 简单push
            /// pushReplacement: 替换当前页面
            Container(height: 10),
            Text("简单push"),
            RaisedButton(
              child: Text('pushReplacement => four page'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FourPage(),
                  ),
                );
              },
            ),

            /// pushAndRemoveUntil
            /*
              一、 最后一个参数 下面两种情况是等价的
                  '(Route<dynamic> route) => false'  和  'ModalRoute.withName(Router.firstPage)'

              二、总结
                pushAndRemoveUntil 最后一个参数：
                1、(Route route) => false 将确保删除推送路线之前的所有路线。 这时候将打开一个新的页面
                2、最后一个参数ModalRoute.withName(Router.secondPage) 中的 page 和 目标页面 之间的页面去掉，
                   但是如过最后一个参数中的pageName是第一个页面，则会和1效果一样
            */
            Container(height: 10),
            RaisedButton(
              child: Text('pushAndRemoveUntil => four page'),
              onPressed: () {
                /// 1、等效 push 或者 ModalRoute.withName(Router.threePage)
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => FourPage()),
                //     (Route<dynamic> route) => true,
                // );

                /// 2、挪除前面所有页面再打开新页面 (等价与  第三个参数为 '(Route route) => false')
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => FourPage()),
                //   ModalRoute.withName(Router.firstPage), // 但是如果替换成"/"则会保留根页面
                // );

                /// 3、挪除前面所有页面再打开新页面 (等价与  第三个参数为 'ModalRoute.withName(Router.第一个页面路由)')
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => FourPage()),
                //   (Route route) => false,
                // );

                /// 4、挪除 指定页面 月 新页面之间的 所有页面
                /// 点击之后 threepage 被挪除
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => FourPage()),
                //   ModalRoute.withName(Router.secondPage),
                // );

                /// 5、根元素 : 挪除所有页面除第一个页面，跳转新页面
                ///   如果直接用Router.firstPage 会挪除所有前面的页面？为什么？
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (BuildContext context) => FourPage()),
                //   ModalRoute.withName("/"),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
