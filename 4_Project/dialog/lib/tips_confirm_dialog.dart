import 'package:flutter/material.dart';
import 'lcfarm_size.dart';
import 'lcfarm_color.dart';
import 'lcfarm_style.dart';

typedef OnCancelListener = Function();
typedef OnConfirmListener = Function();

/// @desc 提示框
/// @time 2019-07-13 17:46
/// @author chenyun
class TipsConfirmDialog extends StatelessWidget {
  ///是否包含温馨提示
  final bool hasTips;

  ///弹窗内容
  final String message;

  ///是否包括取消按钮
  final bool hasCancelButton;

  ///左边取消文本
  final String cancelText;

  ///右边取消文本
  final String confirmText;

  ///左边取消按钮回调
  final OnCancelListener onCancelListener;

  ///右边确定按钮回调
  final OnConfirmListener onConfirmListener;

  TipsConfirmDialog({
    this.hasTips = true,
    @required this.message,
    this.hasCancelButton = true,
    this.cancelText,
    this.confirmText,
    this.onCancelListener,
    this.onConfirmListener,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    if (hasCancelButton) {
      buttons.add(_buildCancelButton());
      buttons.add(Container(
        height: LcfarmSize.dp(24),
        width: LcfarmSize.dp(0.5),
        color: LcfarmColor.color08000000,
      ));
    }
    buttons.add(_buildConfirmButton());

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Container(
          constraints: BoxConstraints(
            maxWidth: LcfarmSize.screenWidth * 0.8,
            minWidth: LcfarmSize.screenWidth * 0.8,
            maxHeight: LcfarmSize.screenHeight * 0.8,
          ),
          decoration: ShapeDecoration(
            color: LcfarmColor.colorFFFFFF,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(LcfarmSize.dp(8)),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(24))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(20)),
                child: Text(
                  hasTips ? "温馨提示" : message,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              hasTips
                  ?
                  // Container(
                  // constraints: BoxConstraints(
                  //   maxHeight: LcfarmSize.screenHeight * 0.6,
                  // ),
                  Flexible(
                      child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: LcfarmSize.dp(20),
                            right: LcfarmSize.dp(20),
                            top: LcfarmSize.dp(10)),
                        child: Text(
                          message,
                          softWrap: true,
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ))
                  : Container(),
              Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(24))),
              Divider(
                color: LcfarmColor.color08000000,
                height: LcfarmSize.dp(0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (onCancelListener != null) {
          onCancelListener();
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        height: LcfarmSize.dp(48),
        child: Text(
          cancelText ?? "取消",
          style: TextStyle(color: Colors.black45),
        ),
      ),
    ));
  }

  Widget _buildConfirmButton() {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (onConfirmListener != null) {
          onConfirmListener();
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        height: LcfarmSize.dp(48),
        child: Text(
          confirmText ?? "确定",
          style: LcfarmStyle.style3776E9_18,
        ),
      ),
    ));
  }
}
