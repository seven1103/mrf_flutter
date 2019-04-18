import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../components/InputGroup.dart';
import '../../components/BContain_button.dart';
import '../../components/SelectDialog.dart';
import '../../components/TextAndPlaceholder.dart';
import '../../components/my_toast.dart';
import '../../service/config.dart';
import '../../components/paypassword.dart';

// import '../../data/constants.dart' show Constants, AppColors;

// String selectA = "下拉选择元素";
// String selectB = "选择转化元素";
// List select = ["锌元素","硒元素","积分"];

class EachTurn extends StatefulWidget {
  final List datalist; //传入硒元素数量
  EachTurn({Key key, this.datalist}) : super(key: key);
  _EachTurnState createState() => _EachTurnState();
}

class _EachTurnState extends State<EachTurn> {
  String selectA = "下拉选择元素";
  String selectB = "";
  //List selectListA = ["锌元素","硒元素"];
  List selectListA = ["积分","硒元素"];
  Map asset_type = {"硒元素":"01","积分":"03"};
  List selectListB = [];
  String ratio = "";
  int returndata=0;
  int inputNUM = 0;
  int maxXinum = 0;
  int maxXinnum = 0;
  int maxJinum = 0;


  void initState() { 
    super.initState();
    maxXinum = int.parse(widget.datalist[0]);
    maxJinum = int.parse(widget.datalist[2]);
  }

  void changeA(String a){
    //selectListB = ["锌元素","硒元素","积分"];
    selectListB = ["硒元素","积分"];
    setState(() {
     selectA = a; 
     selectB = "选择转化元素";
     selectListB.remove(a);
    });
  }
  void changeB(String b){
    setState(() {
     selectB = b; 
     if(selectA=="锌元素"&&selectB=="硒元素"){
       ratio="1锌元素=1硒元素";
       returndata = inputNUM;
     }
     if(selectA=="锌元素"&&selectB=="积分"){
       ratio="1锌元素=900积分";
       returndata = inputNUM*900;
      }
     if(selectA=="硒元素"&&selectB=="锌元素"){
       ratio="1硒元素=1锌元素";
       returndata = inputNUM;
      }
     if(selectA=="硒元素"&&selectB=="积分"){
       ratio="1硒元素=600积分";
       returndata = inputNUM*600;
      }
      if(selectA=="积分"&&selectB=="硒元素"){
        ratio="600积分=1硒元素";
        returndata = inputNUM~/600;
      }
    });
  }

  void inputNum(String num){
    setState(() {
     inputNUM = int.parse(num); 
     changeB(selectB);
    });
  }

  Future submit() async{
    // print(inputNUM);
    //判断是否合格提交
    if(selectA!="下拉选择元素"&&selectB!=""&&inputNUM!=0){
      if(selectA=="锌元素"&&maxXinnum<inputNUM){
        MyToast.showShortToast("锌元素不够");
      }
      else if(selectA=="硒元素"&&maxXinum<inputNUM){
        MyToast.showShortToast("硒元素不够");
      }
      else if(selectA=="积分"&&inputNUM%600!=0){
        MyToast.showShortToast('积分兑换，积分数量应该是600的整数倍');
      }
       else if(selectA=="积分"&&maxJinum<inputNUM){
        MyToast.showShortToast('积分数量不足');
      }
      else{
        final result = await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>PayPsw(title: "确认兑换",
              child: Container(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:  AssetImage("assets/images/logo_pay.png"),
                      radius: 30,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "元素兑换",
                        style: TextStyle(color: Color(0xff333333),fontSize: 18.0,height: 1.5),
                      ),
                    ),
                    Container(child: Text("确定当前"+inputNUM.toString()+selectA+"转换成"+returndata.toString()+selectB+",请输入密码:",style: TextStyle(fontSize: 16.0),),margin: EdgeInsets.only(top: 15.0),),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 30.0, 0, 10.0),
              )
            )));
        //MyToast.showShortToast("完成");
        if(result=='ok'){
            assetConvert();
        }
      }
    }else{
      MyToast.showShortToast("请确认输入");
      print(inputNUM);
    }
  }

  void confirm(){
    submit();
  }
  //资产兑换
  assetConvert() async{
    String assetType;
    String convertAssetType;
    if(selectA=="硒元素"){
      assetType = "01";
      convertAssetType = "03";
    }else{
      assetType = "03";
      convertAssetType = "01";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/asset/assetConvert',
        method: HttpUtils.POST,
        data: {
          "amount": inputNUM.toString(),
          "assetType": assetType,
          "convertAssetType": convertAssetType,
          "token" :prefs.getString('token')
    },context: context);
    if(response['errcode']==200){MyToast.showShortToast('转换成功');Navigator.pop(context,'ok');}
    else{MyToast.showShortToast(response['errmsg']);}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: PageBox(
         title: "元素互转",
         body: Column(
           children: <Widget>[
             Container(
                child: Column(
                  children: <Widget>[
                    InputGroup(label:"选择元素",child: SelectDialog(selectindex: selectA,selectList:selectListA,callback: changeA,)),
                    InputGroup(label:"当前可转元素",child: TextAndPlaceholder(placeholder:"请输入转换数量",isnum: true,callback: inputNum,),rednote: selectA=="硒元素"?"当前可转"+maxXinum.toString()+'个硒元素':(selectA=="积分"?"当前可转"+maxJinum.toString()+'个积分':''),),
                    InputGroup(label:"选择转换元素",child: SelectDialog(selectindex: selectB,selectList:selectListB,callback: changeB,),rednote: ratio,),
                    InputGroup(label:"转换结果",child: Text("    "+ returndata.toString(),style: TextStyle(color: Color(0xffB3B1B1),height: 1.8,fontSize: 16.0))),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
              ),
             BContainButton(bname: "元素互转",callback: confirm)
           ],
         )
       ),
    );
  }
}

