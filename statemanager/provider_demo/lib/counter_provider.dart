import 'package:flutter/material.dart';

class CounterProvide with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increament() {
    _count++;
    notifyListeners();
  }
}
