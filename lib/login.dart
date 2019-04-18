import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'data/constants.dart' show Constants, AppColors;
import 'components/my_toast.dart';
import 'service/config.dart';
import 'homeController.dart';
import 'models/userModel.dart';
class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    //  手机号
  String _account;
  //  密码
  String _password;
  @override
  void initState() {
    super.initState();
    _account = '';
    _password = '';
  }

  // 登录按钮事件
  Future _handleLogin() async {
    if (_account.isEmpty) {
      MyToast.showShortToast("请输入会员账号");
      return;
    } else if (_password.isEmpty) {
      MyToast.showShortToast("请输入密码");
      return;
    }
    var response = await HttpUtils.request('/user/login',
        method: HttpUtils.POST,
        data: {
          'account': _account,
          'password': _password,
          'isAdmin':0
        },context: context);
    if(response["errcode"]==200){
      var result = response["result"];
      MyToast.showShortToast("登录成功");
      //  存值
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('inputpassword', _password);
      result.forEach((a,value){
        prefs.setString(a, value);
      });
      prefs.setString("token", response["token"][0]);
      //Navigator.pushNamed(context, '/HomeController');
      UserModel user = new UserModel(
        id:prefs.getString('id'),
        account:prefs.getString('account'),
        gradeName:prefs.getString('gradeName'),
        nickname:prefs.getString('nicName'),
        icon : prefs.getString('icon'),
        password: prefs.getString('password'),
        payPassword:prefs.getString('payPassword'),
        vipEndTime : prefs.getString('vipEndTime'),
        createDate: formatDate(DateTime.parse(prefs.getString('createDate')), [yyyy, '年', mm, '月', dd, '日']),
        state: prefs.getString('state'),
        token: prefs.getString('token')
      );
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>
                  HomeController(user:user)
      ));
    }
    //print(response);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/logo.png"),
              width: 100,
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            IconData(0xe646,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: Colors.white,
                            size: 14,
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          child: Text(
                            "会员账号",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.2, style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none))),
                          onChanged: (val){
                            _account = val;
                          },
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColors.UNDERLINE_COLOR))),
                  )),
                  Container(
                      child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            IconData(0xe640,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: Colors.white,
                            size: 14,
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          child: Text(
                            "密        码",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.2, style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none))),
                            onChanged: (val){
                              _password = val;
                            },
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColors.UNDERLINE_COLOR))),
                  ))
                ],
              ),
              width: 300,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Text("登录", style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 156, 196, 52))),
                      textColor: Colors.white,
                      onPressed: _handleLogin
                    ),
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 223, 233, 184)),
                        // gradient: LinearGradient(
                        //     colors: [Color(0xffFC7300), Color(0xffFFC618)])),
                  ),
                ],
              ),
              width: 300,
              margin: EdgeInsets.only(top: 30),
            )
          ],
        )),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.center
              )
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
