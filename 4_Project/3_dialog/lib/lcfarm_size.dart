import 'dart:io';
import 'package:device_info/device_info.dart';

/// @desc:屏幕适配
/// @time 2019/3/11 5:07 PM
/// @author chenyun
class LcfarmSize {
  double baseWidth = 375.0;
  double baseHeight = 677.0;

  double scrWidth = 375.0;

  double scrHeight = 677.0;

  double scrScale = 3.0;

  factory LcfarmSize() => _sharedInstance();

  static LcfarmSize _instance;

  LcfarmSize._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static LcfarmSize _sharedInstance() {
    return _instance;
  }

  static Future<LcfarmSize> getInstance() async {
    if (_instance == null) {
      _instance = LcfarmSize._();

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

        assert(androidDeviceInfo != null);

        _instance.scrWidth = androidDeviceInfo.screenWidth;

        _instance.scrHeight = androidDeviceInfo.screenHeight;

        _instance.scrScale = androidDeviceInfo.screenScale;
      } else {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;

        assert(iosDeviceInfo != null);

        _instance.scrWidth = iosDeviceInfo.screenWidth;

        _instance.scrHeight = iosDeviceInfo.screenHeight;

        _instance.scrScale = iosDeviceInfo.screenScale;
      }
    }
    return _instance;
  }

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => 1;

  ///设备的像素密度
  static double get pixelRatio => _instance.scrScale;

  ///当前设备宽度 dp
  static double get screenWidth => _instance.scrWidth;

  ///当前设备高度 dp
  static double get screenHeight => _instance.scrHeight;

  ///当前设备宽度 px
  static double get screenWidthPx => screenWidth * pixelRatio;

  ///当前设备高度 px
  static double get screenHeightPx => screenHeight * pixelRatio;

  ///等待初始化完成
  static void loadAsync() async {
    if (_instance == null) {
      await LcfarmSize.getInstance();
    }
  }

  static double dp(double width) {
    loadAsync();

    return width * _instance.scrWidth / _instance.baseWidth;
  }

  static double sp(double width) {
    return dp(width);
  }
}
