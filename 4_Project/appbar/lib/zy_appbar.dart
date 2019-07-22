import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

const double kZYToolbarHeight = 44.0;

class ZYAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height; // 高度
  final double elevation; // 阴影
  final bool hasBack; // 是否有返回按钮
  final Widget leading; // 左边按钮
  final Widget trailing; // 右边按钮
  final Widget title; // 中间按钮
  final Color bgColor; // 背景色

  ZYAppBar({
    Key key,
    this.leading,
    this.trailing,
    this.elevation,
    this.hasBack = true,
    this.title,
    this.bgColor = Colors.blue,
    this.height = kZYToolbarHeight,
  }) : super(key: key);

  @override
  _ZYAppBarState createState() => _ZYAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ZYAppBarState extends State<ZYAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      child: _container2(),
    );
  }

  Widget _appBar() {
    return Container(
      color: widget.bgColor,
      height: widget.height,
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: _leftWidget()),
          Expanded(flex: 2, child: _centerWiget()),
          Expanded(flex: 1, child: _rigtWidget()),
        ],
      ),
    );
  }

  Widget _container() {
    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Material(
          color: widget.bgColor,
          elevation: 1.0,
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

  Widget _container2() {
    return Container(
      color: widget.bgColor,
      child: SafeArea(
        top: true,
        child: _appBar(),
      ),
    );
  }

  Widget _leftWidget() {
    if (widget.hasBack == true) {
      return _leftBack();
    } else {
      return Container(
        padding: EdgeInsets.only(left: 15),
        child: widget.leading,
      );
    }
  }

  Widget _rigtWidget() {
    if (widget.trailing != null) {
      return Container(
        // color: Colors.blue,
        child: widget.trailing,
      );
    } else {
      return Container();
    }
  }

  Widget _centerWiget() {
    if (widget.title != null) {
      return Container(
        // color: Colors.white,
        alignment: Alignment.center,
        child: widget.title,
      );
    } else {
      return Container();
    }
  }

  Widget _leftBack() {
    return GestureDetector(
      onTap: () {
        print("点击返回");
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        // color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 15)),
            Container(
              width: 12,
              height: 40,
              child: Icon(Icons.arrow_left),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            Text(
              '返回',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
AppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  }) : assert(automaticallyImplyLeading != null),
       assert(elevation == null || elevation >= 0.0),
       assert(primary != null),
       assert(titleSpacing != null),
       assert(toolbarOpacity != null),
       assert(bottomOpacity != null),
       preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
       super(key: key);
 */
