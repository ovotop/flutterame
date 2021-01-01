import 'package:flutter/material.dart';
import 'package:flutterame/about.dart';
import 'package:flutterame/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage(title: '画廊'));
      case '/about':
        // if (args is About) {
        return MaterialPageRoute(builder: (_) => About());
      // }
      // return _errorPage('参数错误');
      default:
        {
          return _errorPage('找不到页面');
        }
    }
  }

  static Route _errorPage(msg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('未知页面')), body: Center(child: Text(msg)));
    });
  }
}
