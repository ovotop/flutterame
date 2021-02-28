import 'package:flutter/material.dart';
import 'dart:ui';

// https://www.jianshu.com/p/b2ad65064ea0
class Adapt {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;
  static double _topbarH = mediaQuery.padding.top;
  static double _botbarH = mediaQuery.padding.bottom;
  static double _pixelRatio = mediaQuery.devicePixelRatio;
  static var _ratio;
  static init(int number) {
    int uiwidth = number is int ? number : 375;
    _ratio = _width / uiwidth;
  }

  static pxByDp(number) {
    if (!(_ratio is double || _ratio is int)) {
      Adapt.init(375);
    }
    return number * _ratio;
  }

  static onePx() {
    return 1 / _pixelRatio;
  }

  static screenWidth() {
    return _width;
  }

  static screenHeight() {
    return _height;
  }

  static topPadding() {
    return _topbarH;
  }

  static bottomPadding() {
    return _botbarH;
  }
}
