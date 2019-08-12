import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provide/provide.dart';
import '../pages/cart_page/cart_page.dart';
import '../pages/home_page/home_page.dart';
import 'category_page.dart';
import '../pages/member_page/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/current_index.dart';

class IndexPage extends StatelessWidget {
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  /// 底部导航
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
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1134)..init(context);
    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
      int currentIndex =
          Provide.value<CurrentIndexProvide>(context).currentIndex;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        // 底部导航
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          },
        ),
        // body:currentPage,
        /// 保持页面状态
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      );
    });
  }
}

/// 使用provide进行改造
// class IndexPage extends StatefulWidget {
//   @override
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage(),
//   ];

//   /// 底部导航
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.home),
//       title: Text('首页'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.search),
//       title: Text('分类'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.shopping_cart),
//       title: Text('购物车'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.profile_circled),
//       title: Text('会员中心'),
//     ),
//   ];

//   int currentIndex = 0;
//   var currentPage;

//   @override
//   void initState() {
//     currentPage = tabBodies[currentIndex];

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1134)..init(context);

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       // 底部导航
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items: bottomTabs,
//         onTap: (index) {
//           setState(() {
//             print(index);
//             currentIndex = index;
//             currentPage = tabBodies[index];
//           });
//         },
//       ),
//       // body:currentPage,
//       /// 保持页面状态
//       body: IndexedStack(
//         index: currentIndex,
//         children: tabBodies,
//       ),
//     );
//   }
// }
