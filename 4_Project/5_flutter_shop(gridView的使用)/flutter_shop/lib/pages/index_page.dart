import 'package:flutter/material.dart'; // Android的风格
import 'package:flutter/cupertino.dart'; //iOS的风格
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  final List tabBodies = [HomePage(), CategoryPage(), CarPage(), MemberPage()];

  int currentIndex = 0; //当前位置
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 一般这个配置都是在前面配置的
    ScreenUtil.instance = ScreenUtil(width: 828, height: 1792)..init(context);

    return Scaffold(
      // backgroundColor: Color.fromARGB(245, 245, 245, 1),

      backgroundColor: Colors.blue,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[index];
          });
        },
      ),
      body: currentPage,
    );
  }
}
