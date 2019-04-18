import 'package:flutter/material.dart';

import 'components/pageBox.dart';

import 'data/constants.dart' show Constants, AppColors;

class RetrievePwd extends StatefulWidget {
  _RetrievePwdState createState() => _RetrievePwdState();
}

class _RetrievePwdState extends State<RetrievePwd> {
  @override
  Widget build(BuildContext context) {
    return PageBox(
      isDefaultAppBar: false,
      title: "找回密码",
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            IconData(0xe63a,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: AppColors.THEME_COLOR,
                            size: 14,
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          child: Text(
                            "手机号",
                            style: TextStyle(
                                color: AppColors.DEFAULT_FONT_COLOR,
                                fontSize: 18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.DEFAULT_FONT_COLOR),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.2, style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none))),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
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
                            IconData(0xe633,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: AppColors.THEME_COLOR,
                            size: 14,
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          child: Text(
                            "验证码",
                            style: TextStyle(
                                color: AppColors.DEFAULT_FONT_COLOR,
                                fontSize: 18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.DEFAULT_FONT_COLOR),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.2, style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none))),
                          ),
                        ),
                        FlatButton(
                          child: Text("获取验证码",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.THEME_COLOR,
                              )),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: AppColors.THEME_COLOR),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          onPressed: () async {},
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
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
                            IconData(0xe63b,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: AppColors.THEME_COLOR,
                            size: 14,
                          ),
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          child: Text(
                            "新密码",
                            style: TextStyle(
                                color: AppColors.DEFAULT_FONT_COLOR,
                                fontSize: 18),
                          ),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.DEFAULT_FONT_COLOR),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.2, style: BorderStyle.none)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none))),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: AppColors.UNDERLINE_COLOR))),
                  )),
                  Container(
                    child: FlatButton(
                      child: Text("提交", style: TextStyle(fontSize: 18)),
                      textColor: Colors.white,
                      onPressed: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return _MessageDialog();
                            });
                      },
                    ),
                    width: 400,
                    height: 50,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                            colors: [Color(0xffFC7300), Color(0xffFFC618)])),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child:
                                    Image.asset("assets/images/tip_icon.png"),
                                width: 20,
                                padding: EdgeInsets.only(right: 5),
                              ),
                              Text(
                                "侗坊小贴士",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.ACCENTCOLOR_FONT_COLOR),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("1.天猫旗舰店购买侗坊产品，凭订单号及个人信息即可申请",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                              Text("2.天猫旗舰店购买侗坊产品，扫描邀请函二维码成为粉丝",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child:
                                    Image.asset("assets/images/tip_icon.png"),
                                width: 20,
                                padding: EdgeInsets.only(right: 5),
                              ),
                              Text(
                                "粉丝福利",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.ACCENTCOLOR_FONT_COLOR),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("1.粉丝每购买一单，平台将返50%利润作为粉丝福利",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                              Text("2.粉丝等级越高，获得更高返利分成",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                              Text("3.不定期粉丝专享活动任性参与",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                              Text("4.粉丝商城专享，更低价格购买，胜人一筹",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.DEFAULT_FONT_COLOR)),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        color: Color.fromRGBO(255, 255, 255, 0.6),
      ),
    );
  }
}

class _MessageDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("成功找回密码",
                      style: TextStyle(
                          fontSize: 24, color: AppColors.THEME_COLOR)),
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  child: FlatButton(
                    child: Text("返回登录", style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                          colors: [Color(0xffFC7300), Color(0xffFFC618)])),
                ),
              ],
            ),
            width: 320,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
