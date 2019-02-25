import 'package:flutter/material.dart';



/// 代码块生成： stful动态widget 
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  final _BottomNavigationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //
        appBar: AppBar(title: Text('bottom'),),
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
                Icons.airplay,
                color: _BottomNavigationColor,
              ),
              title: Text(
                'Airplay',
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
            )
      );
  }
}