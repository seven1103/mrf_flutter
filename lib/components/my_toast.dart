import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//  Toast组件
class MyToast {
  static const int TIME_SHORT = 1;
  static const int TIME_LONG = 2;
  static const Color BG_COLOR = Color.fromRGBO(0, 0, 0, 0.8);
  static const Color TEXT_COLOR = Colors.white;
  //  长时间
  static void showLongToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: TIME_LONG,
        backgroundColor: BG_COLOR,
        textColor: TEXT_COLOR);
  }
  //  短时间
  static void showShortToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: TIME_SHORT,
        backgroundColor: BG_COLOR,
        textColor: TEXT_COLOR);
  }
}
