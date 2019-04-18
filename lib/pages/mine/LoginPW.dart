import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/TextAndPlaceholder.dart';
import '../../components/BContain_button.dart';
import '../../components/my_toast.dart';
import '../../service/config.dart';

// import '../../data/constants.dart' show Constants, AppColors;

class LoginPW extends StatefulWidget {
  final String account;

  LoginPW({Key key, this.account}) : super(key: key);

  _LoginPWState createState() => _LoginPWState();
}

class _LoginPWState extends State<LoginPW> {
  String oldpsw;
  String newpsw;
  String renewpsw;
  void initState() { 
    super.initState();
    oldpsw = '';
    newpsw = '';
    renewpsw = '';
  }
  Future submit() async{
    // RegExp PASSWORD = new RegExp(r"\d{17}[\d|x]|\d{15}");
    // print(PASSWORD.hasMatch("My id number is 35082419931023527x"));
    // return;
    if(oldpsw.isEmpty){
      MyToast.showLongToast('请输入旧密码');
      return;
    }
    else if(newpsw.isEmpty){
      MyToast.showLongToast('请输入新密码');
      return;
    }
    else if(!RegExp(r"^[a-zA-Z0-9]\w{5,11}$").hasMatch(newpsw)){
      MyToast.showLongToast('长度在6-18之间');
      return;
    }
    else if(renewpsw.isEmpty){
      MyToast.showLongToast('请确认新密码');
      return;
    }
    else if(newpsw != renewpsw){
      MyToast.showLongToast('密码不一致');
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/user/resetPwd',
        method: HttpUtils.POST,
        data: {
          'account': widget.account,
          'oldPwd':oldpsw,
          'newPwd': newpsw,
          'token':prefs.getString('token')
      },context: context);
    if(response['errcode']==200){
      MyToast.showShortToast('修改成功');
      Navigator.pop(context);
    }else{
      MyToast.showShortToast(response['errmsg']);
    }
  }

  void getoldpsw(val){
    oldpsw = val.trim();
  }
  void getnewpsw(val){
    newpsw = val.trim();
  }
  void rgetnewpsw(val){
    renewpsw = val.trim();
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title:"修改登录密码",
      haveBack: true,
      body:Column(
        children: <Widget>[
          Container(
            child:Column(
              children: <Widget>[
                // Container(
                //   child: TextAndPlaceholder(placeholder:"输入手机号",isnum: true,callback: getphone),decoration: BoxDecoration(
                //   border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                // )),
                Container(
                  child: TextAndPlaceholder(placeholder: "输入旧密码",isnum: true,ispsw: true,callback: getoldpsw),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                  )
                ),
                Container(
                  child: TextAndPlaceholder(placeholder: "输入新密码",isnum: true,ispsw: true,callback: getnewpsw,),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                  )
                ),
                Container(
                  child: TextAndPlaceholder(placeholder: "确认新密码",isnum: true,ispsw: true,callback: rgetnewpsw,),
                )
              ],
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
          BContainButton(bname: "完成",callback: submit,),
        ],
      )
    );
  }
}