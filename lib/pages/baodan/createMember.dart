import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/TextAndPlaceholder.dart';
import '../../components/BContain_button.dart';
import '../../components/my_toast.dart';
import '../../service/config.dart';

class CreateMember extends StatefulWidget {
  final int type;
  final String healthLineId;
  final String parentAccount;
  CreateMember({Key key, this.type,this.healthLineId,this.parentAccount}) : super(key: key);

  _CreateMemberState createState() => _CreateMemberState();
}

class _CreateMemberState extends State<CreateMember> {
  String nickname;
  String account;
  String password;
  void initState() { 
    super.initState();
    nickname = '';
    account = '';
    password ='';
  }

  xianlu(){
    if(widget.type==1){return "线路一";}
    if(widget.type==2){return "线路二";}
    if(widget.type==3){return "线路三";}
  }

  //创建账户
  void pushData(BuildContext context) async{
    if (nickname.isEmpty) {
      MyToast.showShortToast("请设置会员昵称");
      return;
    } else if (nickname.length>6) {
      MyToast.showShortToast("会员昵称请控制在六位以内");
      return;
    }else if (!RegExp(r"^[A-Za-z]\w{4,11}$").hasMatch(account)) {
      MyToast.showShortToast("账号为字母数字组合,长度应控制在5-12位之间");
      return;
    }else if (account.isEmpty) {
      MyToast.showShortToast("请设置会员账号");
      return;
    } else if (password.isEmpty) {
      MyToast.showShortToast("请设置登录密码");
      return;
    } else if (!RegExp(r"^[a-zA-Z0-9]\w{5,11}$").hasMatch(password)) {
      MyToast.showLongToast('长度在6-12之间');
      return;
    } 
    //验证是否锌元素和硒元素
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getDouble("asset_xi")>=1&&prefs.getDouble("asset_xin")>=1){
      var response = await HttpUtils.request('/user/newUser',
        method: HttpUtils.POST,
        data: {
          'createrAccount':prefs.getString('account'),
          'parentAccount': widget.parentAccount, 
          'account': account,
          'pwd': password,
          'nicName': nickname,
          'token':prefs.getString('token'),
          'lineId':widget.healthLineId,
      });
      if(response["errcode"]==200){
        MyToast.showLongToast("创建成功");
        Navigator.pop(context);
      }else{
        MyToast.showLongToast(response['errmsg']);
      }
    }else{
      MyToast.showShortToast("你的元素不足");
    }
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "创建账户",
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                   child: Container(
                     child: Text(xianlu(),textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0),),
                     width: double.infinity,
                   ),
                    padding: EdgeInsets.all(10.0),
                   decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                   )
                ),
                Container(
                  child: TextAndPlaceholder(placeholder: "会员昵称",callback: (val){
                    nickname=val.trim();
                  },),
                   decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                    )
                ),
                Container(
                  child: TextAndPlaceholder(placeholder: "会员账号",callback: (val){account=val.trim();}),
                   decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                    )
                ),
                Container(
                  child: TextAndPlaceholder(placeholder: "设置登录密码",callback: (val){password=val.trim();}),
                ),
              ],
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
          Container(
            child: Text('(当前创建账户将花费您的一个锌元素和一个硒元素)',style: TextStyle(color: Colors.red,fontSize: 12.0),),
            margin: EdgeInsets.only(top: 10.0),
          ),
          BContainButton(bname: "完成创建",callback: (){
            pushData(context);
          },)
        ],
      )
    );
  }
}
