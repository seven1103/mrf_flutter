import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/TextAndPlaceholder.dart';
import '../../components/BContain_button.dart';
import '../../models/userModel.dart';
import '../../service/config.dart';
import '../../components/my_toast.dart';
// import '../../data/constants.dart' show Constants, AppColors;

class PayPW extends StatefulWidget {
  final UserModel user;
  PayPW({Key key, this.user}) : super(key: key);

  _PayPWState createState() => _PayPWState();
}

class _PayPWState extends State<PayPW> {
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
    var postData;
    //输入效验
    if(newpsw.isEmpty){
      MyToast.showShortToast('请输入支付密码');
      return;
    }else if(!RegExp(r"^\d{6}$").hasMatch(newpsw)){
      MyToast.showShortToast('请输入六位有效数字');
      return;
    }else if(renewpsw.isEmpty){
      MyToast.showShortToast('请确认支付密码');
      return;
    }else if(newpsw!=renewpsw){
      MyToast.showShortToast('密码不一致');
      return;
    }
    postData = {"newPwd":newpsw,"account":widget.user.account};
    //判断是否有旧密码
    if(widget.user.payPassword!=null){
      if(oldpsw.isEmpty){
        MyToast.showShortToast('请输入旧的支付密码');
        return;
      }else{
        postData['oldPwd'] = oldpsw;
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    postData['token'] = prefs.getString('token');
    var response = await HttpUtils.request('/user/resetPayPwd',
      method: HttpUtils.POST,
      data:postData,
      context: context
    );
    //print(response);
    if(response['errcode']==200){
      MyToast.showShortToast('修改成功');
      setState(() {
       widget.user.payPassword =  newpsw;
      });
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
      title: "支付密码",
      haveBack: true,
      body:Center(
        child: Column(
          children: <Widget>[
            Container(
              child:Column(
                children: <Widget>[
                  widget.user.payPassword!=null?Container(
                    child: TextAndPlaceholder(placeholder: "输入旧支付密码",isnum: true,ispsw: true,callback: getoldpsw,),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                    )
                  ):Text(''),
                  Container(
                    child: TextAndPlaceholder(placeholder: "输入支付密码",isnum: true,ispsw: true,callback: getnewpsw,),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                    )
                  ),
                  Container(
                    child: TextAndPlaceholder(placeholder: "确认支付密码",isnum: true,ispsw: true,callback: rgetnewpsw,),
                  )
                ],
              ),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
            ),
            BContainButton(bname: "完成",callback: submit,)
          ],
        )
      )
    );
  }
}