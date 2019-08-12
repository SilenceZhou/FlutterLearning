import 'package:flutter/material.dart';
import 'dart:ui';

/// @Description: 通用弹框(支持关闭按钮)
///
/// @Author: SilenceZhou
/// @Date: 2019/08/01
class LCAlertDialog extends StatelessWidget {
  /// 标题
  final String title;

  /// 内容
  final String message;

  /// 内容对齐模式(默认居左)
  final TextAlign messageTextAlign;

  /// 点击阴影是否消失弹框，默认是不消失的
  final bool barrierDismissible;

  /// 是否有关闭按钮
  final bool isHasClose;

  /// 右上角关闭按钮
  final Function onCloseEvent;

  /// 按钮 - 左边 (文案：灰色)
  final String leftButtonText;

  /// 左边按钮事件 - 默认点击取消
  final Function leftButtonTap;

  /// 右边按钮文案 (文案：主题色)
  final String rightButtonText;

  /// 右边按钮点击事件
  final Function rightButtonTap;

  LCAlertDialog({
    Key key,
    this.title,
    this.message,
    this.messageTextAlign = TextAlign.left,
    this.barrierDismissible,
    this.leftButtonText,
    this.leftButtonTap,
    this.rightButtonText,
    this.rightButtonTap,
    this.isHasClose = false,
    this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      /// 因为Material为全屏，默认为白色，需要设置透明色;
      /// Dailog默认是可以弹框的，同样因为Material为全屏，
      /// 截取了点击消失事件，所以的自己添加一个透明蒙层加个点击事件
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          /// 添加一层便于添加点击消失事件
          GestureDetector(
            onTap: barrierDismissible == true
                ? () {
                    Navigator.pop(context);
                  }
                : null,
            child: Container(color: Colors.transparent),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 只显示内容需要的高度
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _dailogContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _dailogContent(BuildContext context) {
    /// 带关闭按钮的
    if (isHasClose != null && isHasClose) {
      return [
        _topClose(context),
        _title(),
        _titleMessageMarginClose(),
        _message(),
        _messageBottomMarginClose(),
        _buildBottomButtonGroup(context),
      ];
    } else {
      /// 无关闭按钮
      return [
        _topMargin(),
        _title(),
        _titleMessageMargin(),
        _message(),
        _messageBottomMargin(),
        _buildBottomButtonGroup(context),
      ];
    }
  }

  ////////////////////////////////////////////////////////////
  ///    margin
  ////////////////////////////////////////////////////////////

  ///--------------- 有close按钮 ------------------------------
  /// topClose title margin
  Widget _titleMessageMarginClose() {
    double margin = 0.0;
    if (title != null &&
        title.isNotEmpty &&
        message != null &&
        message.isNotEmpty) {
      margin = 10.0;
    }
    return Padding(padding: EdgeInsets.only(top: margin));
  }

  /// 带关闭按钮 massage bottom 间距
  Widget _messageBottomMarginClose() {
    double margin = 30.0;
    if ((title != null && title.isNotEmpty) ||
        (message != null && message.isNotEmpty)) {
      if ((rightButtonText != null && rightButtonText.isNotEmpty) ||
          (leftButtonText != null && leftButtonText.isNotEmpty)) {
        margin = 24.0;
      }
    }
    return Padding(padding: EdgeInsets.only(top: margin));
  }

  ///---------------------------------------------
  ///   没有close按钮
  ///---------------------------------------------
  /// topMargin
  Widget _topMargin() {
    return Padding(padding: EdgeInsets.only(top: 24));
  }

  Widget _titleMessageMargin() {
    double margin = 0.0;
    if (title != null &&
        title.isNotEmpty &&
        message != null &&
        message.isNotEmpty) {
      margin = 10.0;
    }
    return Padding(padding: EdgeInsets.only(top: margin));
  }

  Widget _messageBottomMargin() {
    return Padding(padding: EdgeInsets.only(top: 24));
  }

  ///////////////////////////////////////////////////////////
  ///    各部分子控件
  ///////////////////////////////////////////////////////////

  /// top colse 顶部关闭按钮
  Widget _topClose(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Center(),
        GestureDetector(
          onTap: () {
            if (onCloseEvent != null) {
              this.onCloseEvent();
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
            color: Colors.transparent,
            height: 28,
            width: 28,
            child: Icon(Icons.close, size: 12, color: Color(0xffe0e0e0)),
          ),
        )
      ],
    );
  }

  /// title
  Widget _title() {
    if (title != null && title.isNotEmpty) {
      return Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  /// message
  Widget _message() {
    if (message != null && message.isNotEmpty) {
      return Flexible(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              message,
              style: TextStyle(fontSize: 16.0),
              textAlign: messageTextAlign,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  /// 底部按钮容器
  Widget _buildBottomButtonGroup(BuildContext context) {
    var widgets = <Widget>[];

    if (leftButtonText != null && leftButtonText.isNotEmpty) {
      widgets.add(_buildBottomCancelButton(context));
      if (_isHasMidSeparator()) {
        widgets.add(
          Container(width: 0.5, height: 48, color: Color(0xffe9Eaee)),
        );
      }
    }

    if (rightButtonText != null && rightButtonText.isNotEmpty) {
      widgets.add(_buildBottomrightButtonButton());
    }
    return Container(
      child: Column(
        children: <Widget>[_bottomSeparator(), Row(children: widgets)],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////

  /// 底部分割线控件
  Widget _bottomSeparator() {
    if (_isHasBottomSeparator()) {
      return Container(height: 0.5, color: Color(0xffe9Eaee));
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  /// 是否有 底部分割线
  bool _isHasBottomSeparator() {
    return (leftButtonText != null && leftButtonText.isNotEmpty) ||
        (rightButtonText != null && rightButtonText.isNotEmpty);
  }

  /// 底部双按钮中间分割线
  bool _isHasMidSeparator() {
    return leftButtonText != null &&
        leftButtonText.isNotEmpty &&
        rightButtonText != null &&
        rightButtonText.isNotEmpty;
  }

  /// 左边按钮
  Widget _buildBottomCancelButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (leftButtonTap != null) {
            leftButtonTap();
          } else {
            Navigator.pop(context);
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          height: 48,
          child: Text(leftButtonText, style: TextStyle(fontSize: 16.0)),
        ),
      ),
    );
  }

  /// 右边按钮
  Widget _buildBottomrightButtonButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (rightButtonTap != null) {
            rightButtonTap();
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.transparent,
          height: 48,
          child: Text(
            rightButtonText,
            style: TextStyle(fontSize: 16.0, color: Color(0xff10bfc7)),
          ),
        ),
      ),
    );
  }
}
