import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class CurrentIndexProvide extends ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
