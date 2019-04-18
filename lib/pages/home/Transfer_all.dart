import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/InputGroup.dart';
import '../../components/BContain_button.dart';
import '../../components/TextAndPlaceholder.dart';
import '../../components/my_toast.dart';
import '../../components/paypassword.dart';
import '../../service/config.dart';

class TransferAll extends StatefulWidget {
  final List listData; 
  final int type;
  TransferAll({Key key, this.listData,this.type}) : super(key: key);
  _TransferAllState createState() => _TransferAllState();
}

class _TransferAllState extends State<TransferAll> {
   String titleName;
   List typeList = ['硒元素','锌元素','积分'];
   String toaccount;
   String setnum;
   String usertoken;
  void initState() { 
    super.initState();
    titleName = typeList[widget.type];
  }
  void toAccount(String a){
    toaccount = a;
  }
  void setNum(String num){
    setnum = num;
  }
    //图片资源拼接
    //查询转账用户
  userinfo(String useraccount) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertoken = prefs.getString('token');
    var response = await HttpUtils.request('/user/userInfo',
        method: HttpUtils.POST,
        data: {
          "account": useraccount,
          "token" : prefs.getString('token')
    });
    return response;
  }
  
  void submit(){
    if(toaccount==null&&setnum==null){
      MyToast.showShortToast("请输入完整");
    }else{
      if(int.parse(widget.listData[widget.type]) < int.parse(setnum)) {
        MyToast.showShortToast(titleName+"不足");
      }   
      else {
        userinfo(toaccount).then((data)async{
          var userdata = data['result'];
          if(data['errcode']==200){
            if(data['result']==null){
              MyToast.showShortToast('当前用户不存在');
            }else{
              final result = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>PayPsw(title: "确认转账",
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:  userdata['icon']==null?AssetImage("assets/images/user.png"):NetworkImage(HttpUtils.API_PREFIX +'/file/down?fid='+ userdata['icon']+"&token="+usertoken),
                        radius: 30,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "          "+userdata['nicName'],
                          style: TextStyle(color: Color(0xff333333),fontSize: 18.0,height: 1.5),
                          children: <TextSpan>[
                            TextSpan(text:"  "+userdata['account'],style: TextStyle(color: Color(0xff333333),fontSize: 14.0)),
                          ]
                        ),
                      ),
                      Container(child: Text("确定给"+userdata['nicName']+"转账"+setnum.toString()+'个'+titleName+",请输入密码:",style: TextStyle(fontSize: 16.0),),margin: EdgeInsets.only(top: 15.0),),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(0, 30.0, 0, 10.0),
                )
              )));
              if(result=='ok'){
                //print('返回成功-------');
                assetTransfer();
              }
            }
          }else{
            MyToast.showShortToast(data['errmsg']);
          }
        });
      }
    }
  }
  void confirm(){
    submit();
  }
  //转账接口
  Future assetTransfer() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/asset/assetTransfer',
        method: HttpUtils.POST,
        data: {
          "amount": setnum,
          "assetType": '0'+(widget.type+1).toString(),
          "toAccount":toaccount,
          "token" : prefs.getString('token')
    },context: context);
    if(response['errcode']==200){
      MyToast.showShortToast('转账成功');
      Navigator.pop(context,'ok');
    }else{
      MyToast.showShortToast(response['errmsg']);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: PageBox(
         title: titleName,
         body: Column(
           children: <Widget>[
             Container(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        InputGroup(label:"转账用户",child: TextAndPlaceholder(placeholder:"请输入转账账户",callback: toAccount)),
                        InputGroup(label:"转账数量",child: TextAndPlaceholder(placeholder:"请输入转账数量",isnum: true,callback: setNum),rednote: "当前可转"+widget.listData[widget.type]),
                        
                      ],
                    ),
                    padding: EdgeInsets.all(10.0),
                    color: Colors.white
                  ),
              ),
             BContainButton(bname: '立即转账',callback: confirm)
           ],
         )
       ),
    );
  }
}
