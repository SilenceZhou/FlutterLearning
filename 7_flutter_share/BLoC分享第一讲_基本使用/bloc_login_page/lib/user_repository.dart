/// version:0.0.1
/// author:SileceZhou
/// Company: Lcfarm
/// Date:2019:03:12
/// Github:https://github.com/SilenceZhou

import 'dart:async';
import 'package:flutter/material.dart';

/// 管理用户的数据类
///
/// 为简单起见，我们的UserRepository只是模拟数据存贮所有不同的实现
/// 但在实际应用程序中，您可能会注入HttpClient以及Flutter Secure Storage之类的东西，
/// 以便请求令牌并将其读/写到密钥库/密钥链。
class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
