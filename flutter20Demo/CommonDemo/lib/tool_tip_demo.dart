import 'package:flutter/material.dart';



class ToolTipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tool tip demo'),),
      body: Center(
        // Dialog、Snackbar和BottomSheet都是重量级的控件，轻量级的提示ToolTip
        // 当用户长按被Tooltip包裹的Widget时，会自动弹出相应的操作提示。
        child: Tooltip(
          message: '不要碰我',
          child: Image.network('http://desk.fd.zol-img.com.cn/t_s1680x1050c5/g5/M00/09/01/ChMkJlwThk-IH5f7AAKFQvC40v4AAtyjQAH-CoAAoVa592.jpg?downfile=1550826654874.jpg'),
        ),
      ),
    );
  }
}