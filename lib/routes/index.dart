import 'package:flutter/material.dart';
import 'package:flutter_shop_app/pages/Login/index.dart';
import 'package:flutter_shop_app/pages/Main/index.dart';

Widget getRootWidget() {
  return MaterialApp(
    initialRoute: "/",
    routes: getRootRoutes(),
    onGenerateRoute: (settings) {
      return null;
    },
    onUnknownRoute: (settings) {
      return null;

      // return MaterialPageRoute(builder: (context) => NotFound());
    },
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/": (context) => MainPage(), // 主页
    "/login": (context) => LoginPage(), // 登录页面
  };
}
