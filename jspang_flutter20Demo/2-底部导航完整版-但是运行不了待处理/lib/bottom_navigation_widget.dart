import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/pages_screen.dart';
import 'pages/email_screen.dart';
import 'pages/account_screen.dart';



/// 代码块生成： stful动态widget 
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  final _BottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();
    
  // 重写初始化方法
  // ..add是建造者模式，谁用这个方法返回谁  list用这个 且返回这个list（类似于链式编程）
  @override
  void initState(){
    // list
    //   ..add(HomeScreen())
    //   ..add(PagesScreen())
    //   ..add(EmailScreen())
    //   ..add(AccountScreen());
    list = [
      HomeScreen(),
      PagesScreen(),
      EmailScreen(),
      AccountScreen()
    ];

    super.initState();// 空格的重要性
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //
       // appBar: AppBar(title: Text('bottom'),),

        body: list[_currentIndex],

        // 目前点击不了
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Home',
                style:TextStyle(color:_BottomNavigationColor)
              )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Pages',
                style:TextStyle(color:_BottomNavigationColor)
              )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Email',
                style:TextStyle(color:_BottomNavigationColor)
              )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Account',
                style:TextStyle(color:_BottomNavigationColor)
              )),
          ],
          // 哪个高亮了
          currentIndex: _currentIndex,
          onTap: (int index){
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
            )
      );
  }
}