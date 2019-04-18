import 'package:flutter/material.dart';
import '../../components/pay_keyboard/CustomJPasswordFieldWidget.dart';
import '../../components/pay_keyboard/keyboard_widget.dart';
import '../../components/pay_keyboard/pay_password.dart';

import '../../data/constants.dart' show AppColors, Constants;
//  支付键盘
class PayKeyBoard extends Dialog {
  final handleSubmit;
  PayKeyBoard({Key key, @required this.handleSubmit})
      : assert(handleSubmit != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(type: MaterialType.transparency, child: _PayKeyBoardBox(handleSubmit:(val){
      handleSubmit(val);
    }));
  }
}

class _PayKeyBoardBox extends StatefulWidget {
  final handleSubmit;
  _PayKeyBoardBox({Key key, this.handleSubmit})
      : assert(handleSubmit != null),
        super(key: key);
  _PayKeyBoardBoxState createState() => _PayKeyBoardBoxState();
}

class _PayKeyBoardBoxState extends State<_PayKeyBoardBox> {
  String pwdData = '';
  //  按键回调
  void _onKeyDown(KeyEvent data) {
    if (data.isDelete()) {
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      if (pwdData.length != 6) {
//        Fluttertoast.showToast(msg: "密码不足6位，请重试", gravity: ToastGravity.CENTER);
        return;
      }
      widget.handleSubmit(pwdData);
    } else {
      if (pwdData.length < 6) {
        pwdData += data.key;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      Container(
                        child: Text("请输入支付密码",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.ACCENTCOLOR_FONT_COLOR,
                                fontSize: 16)),
                        width: double.infinity,
                      ),
                      //  返回
                      IconButton(
                        icon: Icon(
                            IconData(0xe61a,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            size: 22,
                            color: AppColors.SECONDARYCOLOR_FONT_COLOR),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  width: double.infinity,
                ),
                //  密码框
                Container(
                  width: 260.0,
                  height: 50.0,
                  child: new CustomJPasswordField(pwdData),
                  margin: EdgeInsets.only(top: 20),
                ),
                //  忘记密码
                Container(
                  child: FlatButton(
                    child: Text("忘记密码?",
                        style: TextStyle(
                            color: AppColors.THEME_COLOR, fontSize: 12)),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                    onPressed: () async {},
                  ),
                  height: 30,
                  width: 80,
                ),
                //  键盘
                Container(
                  child: MyKeyboard(_onKeyDown),
                  margin: EdgeInsets.only(top: 30),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
