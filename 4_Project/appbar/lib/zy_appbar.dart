import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

/// 分割线颜色
const double kZYSeparatorHeight = 0.5;

/// 分割线颜色
const Color kColorffe9Eaee = const Color(0xffe9Eaee);

/// 状态栏颜色
enum ZYStatusBarStyle {
  /// 白色
  light,

  /// 黑色
  dark
}

class ZYAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// 中间控件
  final Widget title;

  /// 左边控件
  final Widget leading;

  /// 右边控件
  final Widget trailing;

  /// 背景色
  final Color backgroundColor;

  /// 是否显示分割线， 默认显示 true
  final bool isShowSeparator;

  /// 分割线颜色，默认灰色 色值为 kColorffe9Eaee
  final Color separatorColor;

  /// 左边按钮是否有返回控件，默认显示, 如果没有则
  final bool hasBack;

  /// 状态栏颜色, 默认为dark
  final ZYStatusBarStyle statusBarStyle;

  /// 阴影高度
  final double elevation;

  /// AppBar高度, 注意：iPhone X系列不包括SafeArea的高度
  final double _height = Platform.isAndroid ? 48.0 : 44.0;

  ZYAppBar({
    Key key,
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor = Colors.white,
    this.isShowSeparator = true,
    this.separatorColor = kColorffe9Eaee,
    this.hasBack = true,
    this.statusBarStyle = ZYStatusBarStyle.dark,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  _ZYAppBarState createState() => _ZYAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_height + kZYSeparatorHeight);
}

class _ZYAppBarState extends State<ZYAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: _container(context),
    );
  }

  Widget _container(BuildContext context) {
    /// 状态栏颜色
    SystemUiOverlayStyle overlayStyle =
        widget.statusBarStyle == ZYStatusBarStyle.dark
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          /// 分割线
          shape: Border(
            bottom: BorderSide(
              width: kZYSeparatorHeight,
              color: widget.separatorColor,
            ),
          ),
          elevation: widget.elevation,
          color: widget.backgroundColor,
          child: SafeArea(
            top: true,
            child: Semantics(
              explicitChildNodes: true,
              child: _appBar(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      color: widget.backgroundColor,
      height: widget._height,
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: _leftWidget()),
          Expanded(flex: 2, child: _centerWiget()),
          Expanded(flex: 1, child: _rigtWidget()),
        ],
      ),
    );
  }

  /// 左中右各 分组件
  Widget _centerWiget() {
    if (widget.title != null) {
      return Container(
        // 测试调试
        // color: Colors.red,
        alignment: Alignment.center,
        child: widget.title,
      );
    } else {
      return Container();
    }
  }

  Widget _rigtWidget() {
    if (widget.trailing != null) {
      return Container(
        // 测试调试
        // color: Colors.yellow,
        alignment: Alignment.centerRight,
        child: widget.trailing,
      );
    } else {
      return Container();
    }
  }

  Widget _leftWidget() {
    if (widget.hasBack == true) {
      return _leftBack();
    } else {
      return Container(
        // 测试调试
        // color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 15),
        child: widget.leading,
      );
    }
  }

  Widget _leftBack() {
    return GestureDetector(
      onTap: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 15)),
            Container(
              width: 12,
              height: 40,
              child: Image.asset('images/2.0x/nav_back_icon.png'),
            ),
            Padding(padding: EdgeInsets.only(left: 5)),
            Text(
              '返回',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//========================================
// 没办法改变状态栏颜色
//  Widget _container() {
//     return Container(
//       color: widget.backgroundColor,
//       child: SafeArea(
//         top: true,
//         child: _appBar(),
//       ),
//     );
//   }
