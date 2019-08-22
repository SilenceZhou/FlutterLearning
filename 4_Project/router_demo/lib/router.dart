import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';
import 'three_page.dart';
import 'four_page.dart';

class Router {
  static const String firstPage = "firstPage";
  static const String secondPage = "secondPage";
  static const String threePage = "threePage";
  static const String fourPage = "fourPage";

  static Map<String, WidgetBuilder> routes = {
    Router.firstPage: (context) => FirstPage(),
    Router.secondPage: (context) => SecondPage(),
    Router.threePage: (context) => ThreePage(),
    Router.fourPage: (context) => FourPage(),
  };
}
