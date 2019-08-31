import 'package:changestatubarcolor/second_page_appbar.dart';
import 'package:changestatubarcolor/second_page_no_appbar.dart';
import 'package:flutter/material.dart';

import 'appbar_and_body.dart';
import 'appbar_and_body_next.dart';
import 'first_page_appbar.dart';
import 'firt_page_no_appbar.dart';
import 'home_page.dart';

class Router {
  static const String homePage = "/";
  static const String firstAppBar = "firstAppBar";
  static const String firstNoAppBar = "firstNoAppBar";
  static const String appBarAndBody = "appBarAndBody";

  static const String appBarToAppBar = "appBarToAppBar";
  static const String appBarToNoAppBar = "appBarToNoAppBar";
  static const String noAppBarToAppBar = "noAppBarToAppBar";
  static const String noAppBarToNoAppBar = "noAppBarToNoAppBar";
  static const String appBarBodyToAppBarBodyNext = "appBarBodyToAppBarBodyNext";

  static Map<String, WidgetBuilder> routers(BuildContext context) {
    return {
      Router.homePage: (context) => HomePage(),
      Router.firstAppBar: (context) => FirstPageAppBar(),
      Router.firstNoAppBar: (context) => FirstPageNoAppBar(),
      Router.appBarAndBody: (context) => AppBarAndBody(),
      //
      Router.appBarToAppBar: (context) => SecondPageAppBar(),
      Router.appBarToNoAppBar: (context) => SecondPageNoAppBar(),
      Router.noAppBarToAppBar: (context) => SecondPageAppBar(),
      Router.noAppBarToNoAppBar: (context) => SecondPageNoAppBar(),
      Router.appBarBodyToAppBarBodyNext: (context) => AppBarAndBodyNext(),
    };
  }

  // static Map<String, WidgetBuilder> routes = {
  //   Router.homePage: (context) => HomePage(),
  //   Router.firstAppBar: (context) => FirstPageAppBar(),
  //   Router.firstNoAppBar: (context) => FirstPageNoAppBar(),
  //   Router.appBarAndBody: (context) => AppBarAndBody(),
  //   //
  //   Router.appBarToAppBar: (context) => SecondPageAppBar(),
  //   Router.appBarToNoAppBar: (context) => SecondPageNoAppBar(),
  //   Router.noAppBarToAppBar: (context) => SecondPageAppBar(),
  //   Router.noAppBarToNoAppBar: (context) => SecondPageNoAppBar(),
  //   Router.appBarBodyToAppBarBodyNext: (context) => AppBarAndBodyNext(),
  // };
}
