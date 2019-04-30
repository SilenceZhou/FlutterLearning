/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  final Widget child;

  LoadingIndicator({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 675)..init(context);
    print('设备的高${ScreenUtil.screenHeight}');
    print('设备的宽度${ScreenUtil.screenWidth}');
    return Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil.screenHeight,
      color: Colors.pinkAccent,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
