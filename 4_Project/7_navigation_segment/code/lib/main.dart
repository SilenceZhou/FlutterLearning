import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// 主页设置
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

/** SingleTickerProviderStateMixin
  Provides a single [Ticker] that is configured to only tick while the current 
  tree is enabled, as defined by [TickerMode].

  To create the [AnimationController] in a [State] that only uses a single [AnimationController], 
  mix in this class, then pass vsync: this to the animation controller constructor.

  This mixin only supports vending a single ticker. If you might have multiple [AnimationController] objects over
   the lifetime of the [State], use a full [TickerProviderStateMixin] instead.
*/
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this); //初始化方法
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      key: _scaffoldKey,
      appBar: AppBar(
        // 方法一:给leading赋值builder
        // leading: Builder(
        //   builder: (context) => IconButton(
        //         icon: new Icon(Icons.settings),
        //         onPressed: () => Scaffold.of(context).openDrawer(),
        //       ),
        // ),

        // 方法二:
        leading: IconButton(
          icon: Icon(Icons.account_box),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              icon: Icon(Icons.directions_transit),
            ),
            Tab(
              icon: Icon(Icons.directions_bike),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          HomePage(
            title: "设置",
          ),
          HomePage(
            title: "我2222",
          ),
          HomePage(
            title: "我3333",
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        dragStartBehavior: DragStartBehavior.down,
        children: <Widget>[
          // 1. 简单的头部
          // const DrawerHeader(
          //   child: Center(
          //     child: Text('我是侧边栏'),
          //   ),
          // ),
          // 2.复杂的用户头部
          // UserAccountsDrawerHeader 不能用const来修饰
          UserAccountsDrawerHeader(
            accountEmail: Text(
              '13456@qq.com',
              style: TextStyle(color: Colors.black),
            ),
            accountName: Text(
              'HandsomeMen',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {
                print('current user');
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'http://m.360buyimg.com/pop/jfs/t25441/342/232745157/35324/69b79175/5b696c57N739592b8.jpg'),
              ),
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                onTap: () => print('点击了otherAccountsPictures 111111'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pic.qqtn.com/up/2018-9/15367146917869444.jpg'),
                ),
              ),
              GestureDetector(
                onTap: () => print('点击了otherAccountsPictures 222222'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'http://www.gx8899.com/uploads/allimg/160902/3-160Z2104544.jpg'),
                ),
              ),
            ],
            decoration: BoxDecoration(
              //装饰器提供背景图片
              image: DecorationImage(
                  fit: BoxFit.fill,
                  //使用网络图片怎么有问题
                  image: NetworkImage(
                      'http://www.86ps.com/UpLoadFiles/jpg/2011-10/2011100912585215837.jpg')
                  // image: new ExactAssetImage('images/bg.jpg'),
                  ),
            ),
          ),

          const ListTile(
            leading: Icon(Icons.account_box),
            title: Text('选卡1'),
          ),
          Divider(),
          const ListTile(
            leading: Icon(Icons.account_box),
            title: Text('选卡1'),
          ),
          Divider(),
          const ListTile(
            leading: Icon(Icons.account_box),
            title: Text('选卡1'),
          ),
        ],
      ),
    );
  }
}
