import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/BContain_button.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../service/config.dart';
import '../../components/my_toast.dart';
import '../../models/userModel.dart';
import '../../components/my_toast.dart';
import '../../service/config.dart';


class UserNick extends StatefulWidget {
  final UserModel user;
  UserNick({Key key, this.user}) : super(key: key);

  _UserNickState createState() => _UserNickState();
}

class _UserNickState extends State<UserNick> {
  String nickname;
  Future submit() async{
    if(nickname==null){
      Navigator.pop(context);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await HttpUtils.request('/user/updateUser',
        method: HttpUtils.POST,
        data: {
          'account': widget.user.account,
          'nicName': nickname,
          'token': prefs.getString('token') 
      },context: context);
      MyToast.showLongToast(response['errmsg']);
      if(response['errcode']==200){
        setState(() {
         widget.user.nickname =  nickname;
        });
        Navigator.pop(context);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title:"修改昵称",
      haveBack: true,
      body: Column(
        children: <Widget>[
          Container(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration:InputDecoration(
                hintText: widget.user.nickname,
                fillColor: Colors.white,
                enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: AppColors.THEME_MAIN_COLOR,width: 0.2, style: BorderStyle.solid)),
                focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: AppColors.THEME_MAIN_COLOR,width: 0.5, style: BorderStyle.solid)),
              ),
              onChanged: (val){
                nickname = val;
              },
            ),
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
          ),
          BContainButton(bname: "保存",callback: submit)
        ],
      )
    );
  }
}