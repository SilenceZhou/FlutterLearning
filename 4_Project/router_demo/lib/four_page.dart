import 'package:flutter/material.dart';
import 'router.dart';

class FourPage extends StatefulWidget {
  @override
  _FourPageState createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  void dispose() {
    super.dispose();
    print("FourPage dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Four Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            /// pop : 直接pop
            Padding(padding: EdgeInsets.only(top: 100)),
            RaisedButton(
              child: Text('pop => three page'),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.maybePop(context);
              },
            ),

            /// popAndPushNamed : 先 pop 然后在 push
            Padding(padding: EdgeInsets.only(top: 10)),
            RaisedButton(
              child: Text('popAndPushNamed => first  page'),
              onPressed: () {
                Navigator.popAndPushNamed(context, Router.firstPage);
              },
            ),

            /// popUntil
            /// ModalRoute.withName(Router.page)
            /// 移除 Router.page 之前的所有元素, 但是Router.page 一定不能是跟页面 相同的 page
            /// 如果是根页面相同的 page报错：'package:flutter/src/widgets/navigator.dart': Failed assertion: line 2216 pos 12: '!_debugLocked': flutter: is not true.
            Padding(padding: EdgeInsets.only(top: 10)),
            RaisedButton(
              child: Text('popUntil => first page'),
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName("/"), // 回退到第一个页面
                  // ModalRoute.withName(Router.firstPage), // 直接报错
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
