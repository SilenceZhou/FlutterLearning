import 'package:flutter/material.dart';

///  ChangeNotifier : 管理全量的听众
class Counter with ChangeNotifier {
  int value = 0;

  increase() {
    value++;

    /// 通知所有的听众
    notifyListeners();
  }
}
