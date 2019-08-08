import 'package:flutter/material.dart';

/// 注意点：
/// 1. 继承 ChangeNotifier
/// 2. 定义一个类似于setter / getter方法
/// 3. 在setter方法中 需要调用 notifyListeners();
class Counter with ChangeNotifier {
  int value = 0;

  increase() {
    value++;

    /// 通知所有的听众
    notifyListeners();
  }
}
