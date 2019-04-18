import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/pageBox.dart';
import '../components/pay_keyboard/CustomJPasswordFieldWidget.dart';
import '../components/pay_keyboard/keyboard_widget.dart';
import '../components/pay_keyboard/pay_password.dart';
import '../service/config.dart';
import '../components/my_toast.dart';

class PayPsw extends StatefulWidget {
  final Widget child;
  final String title;
  final String nums;
  final callback;
  PayPsw({Key key, this.child,this.title="密码输入",this.nums,this.callback}) : super(key: key);

  _PayPswState createState() => _PayPswState();
}

class _PayPswState extends State<PayPsw> {
  String pwdData = '';
  void _onKeyDown(KeyEvent data) {
    if (data.isDelete()) {
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      if (pwdData.length != 6) {
        return;
      }else{
        _getData();
        //show();
      }
    } else {
      if (pwdData.length < 6) {
        pwdData += data.key;
      }
      setState(() {});
    }
  }
  
  _getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request("/user/checkPayPwd",
      method: HttpUtils.POST,
      data: {
        "payPwd": pwdData,
        "token": prefs.getString('token')
      },
      //context: context
    );
    if(response['errcode']==200){
      Navigator.pop(context, 'ok');
      //widget.callback;
      //_sumbitData();
    }else{
      MyToast.showShortToast(response['errmsg']);
    }
  }

  // void show(){
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (_) {
  //         return new NetLoadingDialog(
  //           outsideDismiss: false,
  //           requestCallBack: _getData(),
  //         );
  //       });
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: PageBox(
         title: widget.title,
         body: Container(
           child: Column(
             children: <Widget>[
               Container(
                 child: Column(
                   children: <Widget>[
                     widget.child,
                     Container(
                        width: 260.0,
                        height: 50.0,
                        child: new CustomJPasswordField(pwdData),
                        margin: EdgeInsets.only(bottom: 20.0),
                      ),
                   ],
                 ),
                 color: Colors.white,
                 width: double.infinity,
               ),
               Expanded(
                  child: Container(),
                ),
                Container(
                  width: double.infinity,
                  child: MyKeyboard(_onKeyDown),
                )
             ],
           ),
           width: double.infinity,
         )
       ),
    );
  }
}