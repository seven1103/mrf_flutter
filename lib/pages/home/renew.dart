import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../data/constants.dart';
import '../../components/BContain_button.dart';
import '../../components/my_toast.dart';
import '../../components/paypassword.dart';
import '../../service/config.dart';
import '../../components/date_difference.dart';
import '../../models/userModel.dart';

class Renew extends StatefulWidget {
  final Widget child;
  final UserModel user;

  Renew({Key key, this.child,this.user}) : super(key: key);

  _RenewState createState() => _RenewState();
}

class _RenewState extends State<Renew> {
  int amount;
  void initState() { 
    super.initState();
    amount = 0;
  }
  Future submit() async{
    if(amount>0){
      // 传参跳转
      final result = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>PayPsw(
        title: "确认转账",
        nums:amount.toString(),
        child: Container(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage:  AssetImage("assets/images/logo_pay.png"),
                radius: 30,
              ),
              Text.rich(
                TextSpan(
                  text: "支付平台",
                  style: TextStyle(color: Color(0xff333333),fontSize: 18.0,height: 1.5),
                ),
              ),
              Container(child: Text("确定支付"+amount.toString()+"硒元素,请输入密码:",style: TextStyle(fontSize: 16.0),),margin: EdgeInsets.only(top: 15.0),),
            ],
          ),
          padding: EdgeInsets.fromLTRB(0, 30.0, 0, 10.0),
        ),
      )));
      if(result=='ok'){
        _sumbitData();
      }
    }else{
      MyToast.showShortToast('请输入硒元素数量');
    }
  }
  void confirm(){
    submit();
  }

  //支付成功返回处理
_sumbitData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request("/user/recharge",
      method: HttpUtils.POST,
      data: {
        "amount": amount,
        "token": prefs.getString('token')
      },
      context: context
    );
    if(response['errcode']==200){
      MyToast.showShortToast('续费成功');
      // setState(() {
      //   widget.user.vipEndTime = '2019-05-29 18:01:41';
      // });
      _findInfo();
      //Navigator.pop(context,'ok');
    }else{
      MyToast.showShortToast(response['errmsg']);
    }
}

  //查询个人信息
_findInfo() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var response = await HttpUtils.request("/user/userInfo",
    method: HttpUtils.POST,
    data: {
      "account": prefs.getString('account'),
      "token": prefs.getString('token')
    },
    context: context
  );
  if(response['errcode']==200){
    var result = response['result'];
    setState(() {
      widget.user.vipEndTime = result['vipEndTime'];
      widget.user.state = result['state'];
    });
    Navigator.pop(context,'ok');
  }
}
  @override
  Widget build(BuildContext context) {
    return PageBox(
       title: "立即续费",
       body: Container(
         child: Column(
           children: <Widget>[
             ItemInput(Label: "剩余时间",child: DateDifference(enddate: DateTime.parse(widget.user.vipEndTime,),iscolor: true,),),
             ItemInput(Label: "会员账号",child: account(),),
             ItemInput(Label: "会员等级",child: level(),),
             ItemInput(Label: "充值金额",child: Container(
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.right,
                          keyboardType:TextInputType.number,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: AppColors.THEME_MAIN_COLOR,fontSize: 14),
                            hintStyle: TextStyle(color: AppColors.THEME_MAIN_COLOR,fontSize: 14),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.2, style: BorderStyle.none)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.none))
                          ),
                          onChanged: (val){
                            amount = int.parse(val);
                          },
                        ),
                      ),
                      Text("硒元素",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),)
                    ],
                  ),
                ),
              )),
             Expanded(child: Text("")),
             BContainButton(bname: "立即充值",callback: confirm)
            //  FlatButton(
            //    child: Text('点击'),
            //    onPressed: submit
            //  )
           ],
         ),
       ),
    );
  }
}

class ItemInput extends StatefulWidget {
  final Widget child;
  final String Label;

  ItemInput({Key key, this.child,@required this.Label}) : super(key: key);

  _ItemInputState createState() => _ItemInputState();
}

class _ItemInputState extends State<ItemInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         child: Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.Label),
              Container(
                child: widget.child,
              )
            ],
          ),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color:Color(0xfff7f7f7),)),
            //color: Colors.white
          ),
         ),
         color: Colors.white,
       ),
    );
  }
}

class Time extends StatelessWidget {
  final Widget child;

  Time({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("10天35分40秒012",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),),
    );
  }
}

class account extends StatelessWidget {
  final Widget child;

  account({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("gm001"),
    );
  }
}

class level extends StatelessWidget {
  final Widget child;

  level({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("VIP客户"),
    );
  }
}

// class number extends StatelessWidget {
//   final Widget child;
//   final callback;
//   number({Key key, this.child,this.callback}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }