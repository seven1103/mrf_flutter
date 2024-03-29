import 'package:flutter/material.dart';


///  自定义 键盘 按钮

class CustomKbBtn extends StatefulWidget {
  final String text;

  CustomKbBtn({Key key, this.text, this.callback}) : super(key: key);
  final callback;

  _ButtonState createState() => _ButtonState();

}

class _ButtonState extends State<CustomKbBtn> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.callback('$backMethod');
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
        height:50.0,
        child: new OutlineButton(
          // 直角
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(0.0)),
          // 边框颜色
          borderSide: new BorderSide(color: Color(0x10333333)),
          child: new Text(
            widget.text,
            style: new TextStyle(color: Color(0xff333333), fontSize: 20.0),
          ),
          onPressed: back,
        ));
  }
}