import 'dart:async';

import 'package:flutter/services.dart';

/// 插件包的 Dart API
class Hello {
  static const MethodChannel _channel = const MethodChannel('hello');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
