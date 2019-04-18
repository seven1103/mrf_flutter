import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/config.dart';
import '../../components/pageBox.dart';
import '../../components/head_title.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../pages/home/Each_turn.dart';
import '../../pages/home/Transfer_all.dart';
import '../../pages/home/renew.dart';
import '../../pages/home/Statistics.dart';
import '../../models/userModel.dart';
import '../../components/my_toast.dart';
import '../../components/date_difference.dart';


class HomeScreen extends StatefulWidget {
  final UserModel user;
  HomeScreen({Key key,this.user}):super(key:key);
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  UserModel user = new UserModel();
  List assetData;
  List lineData;
  void initState() { 
    super.initState();
    assetData = ['0','0','0','0'];
    lineData = [{"lineUserCountAll":0,"lineUserCountActived":0},
    {"lineUserCountAll":0,"lineUserCountActived":0},{"lineUserCountAll":0,"lineUserCountActived":0}];
    user = widget.user;
    _getasset();
    _getLine();
  }

  //查询资产
  _getasset() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/asset/select',
        method: HttpUtils.POST,
        data: {
          "account":widget.user.account,
          "token" :widget.user.token
    },);
    if(response["errcode"]==200&&response["result"]!=null){
      //缓存资产
      prefs.setDouble("asset_xi", response["result"][0]["value"]);
      prefs.setDouble("asset_xin", response["result"][1]["value"]);
      prefs.setDouble("asset_ji", response["result"][2]["value"]);
      prefs.setDouble("asset_love", response["result"][3]["value"]);

      setState(() {
       for(int i=0;i<4;i++){
         assetData[i] = (response["result"][i]["value"]).toStringAsFixed(0);
       }
      });
    }else{
      print('资产返回错误');
    }
  }

  //查询健康线
  _getLine() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/line/lineUserCount',
        method: HttpUtils.POST,
        data: {
          "account":widget.user.account,
          "token" :widget.user.token
    },context: context);
    if(response['errcode']==200){
      setState(() {
       lineData = response['result']; 
      });
    }else{
      MyToast.showShortToast("健康线查询失败");
    }
  }
  
  //刷新首页数据
  Future _refresh() async{
     _getasset();
    _getLine();
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      hastitle: false,
      body: Center(
        child: Column(
          children: <Widget>[ 
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          HeadTitle(title: "工作台",user:widget.user),
                          _UserHeader(user:user),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage("assets/images/page_header.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center
                            )
                      ),
                    ),
                    Container(
                      child: Text(""),
                      height: 50.0,
                      color: Colors.white,
                    )
                  ],
                ),
                _HealthLine(num: lineData),
              ],
            ),
            Container(
              child: Expanded(
                child: RefreshIndicator(
                  color: AppColors.THEME_MAIN_COLOR,
                  onRefresh: _refresh,
                  child: ListView(
                    children: <Widget>[
                      // _BonusDisplayWall(),
                      //_HealthLine(num:[1,2,3]),
                      _FinaceData(list: assetData,),
                      _Operation(list: assetData,)
                    ],
                ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 头部个人信息
class _UserHeader extends  StatefulWidget{
  final UserModel user;
  _UserHeader({Key key, this.user}) : super(key: key);
  _UserHeaderState createState() => _UserHeaderState();
}
class _UserHeaderState extends State<_UserHeader>{
  //图片资源拼接
String _httpimg(String src) {
  return HttpUtils.IMG_BASEURL + src;
}
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 30.0),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: widget.user.icon!=null?NetworkImage(_httpimg(widget.user.icon)):AssetImage("assets/images/user.png"),
                        //backgroundImage: AssetImage("assets/images/user.png"),
                        radius: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 5.0),                    
                              child: Column(
                                children: <Widget>[
                                  Text(widget.user.nickname,style: TextStyle(fontSize: 16.0,color: Colors.white)
                                  ),
                                  Text(widget.user.account,style: TextStyle(fontSize: 16.0,color: Colors.white))
                                ],
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            padding: EdgeInsets.all(2.0),
                            child: Text(widget.user.gradeName,style: TextStyle(fontSize: 10.0,color: Colors.white)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              color: Color(0xffFABC00)
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: <Widget>[
                        widget.user.state!='2'?DateDifference(enddate: DateTime.parse(widget.user.vipEndTime),):Text('0天0时0分0秒',style: TextStyle(color: Colors.red,fontSize: 16.0,),),
                        //Text("立即续费",style: TextStyle(fontSize: 16.0,color: Colors.white),textAlign: TextAlign.right)
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: FlatButton(
                            child: Text("立即续费",style: TextStyle(color: Color.fromARGB(255, 179, 204, 95)),),
                            onPressed: ()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Renew(user:widget.user)
                                    )
                              ),
                          ),
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class _HealthLine extends  StatefulWidget{
  final List num;
  _HealthLine({Key key, this.num}) :super(key: key);
  _HealthLineState createState() => _HealthLineState();
}
class _HealthLineState extends State<_HealthLine> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe64e,fontFamily: Constants.ICON_FONT_FAMILY),size: 16,color: AppColors.THEME_MAIN_COLOR),
                        Container(
                          child: Text("健康线1",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),),
                          margin: EdgeInsets.only(left:5.0),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top:4.0),
                  ),
                  Text("("+widget.num[0]['lineUserCountActived'].toString()+"/"+widget.num[0]['lineUserCountAll'].toString()+")",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),)
                ],
              ),
              
              //child: Text("123",style: TextStyle(color: Color(0xffB0CD5E)),textAlign: TextAlign.center,),
              height: 50.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0x20B0CD5E),
                borderRadius: BorderRadius.all(Radius.circular(5))
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe64e,fontFamily: Constants.ICON_FONT_FAMILY),size: 16,color: AppColors.THEME_MAIN_COLOR),
                        Container(
                          child: Text("健康线2",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),),
                          margin: EdgeInsets.only(left:5.0),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top:4.0),
                  ),
                  Text("("+widget.num[1]['lineUserCountActived'].toString()+"/"+widget.num[1]['lineUserCountAll'].toString()+")",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),)
                ],
              ),
              
              //child: Text("123",style: TextStyle(color: Color(0xffB0CD5E)),textAlign: TextAlign.center,),
              height: 50.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0x20B0CD5E),
                borderRadius: BorderRadius.all(Radius.circular(5))
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(IconData(0xe64e,fontFamily: Constants.ICON_FONT_FAMILY),size: 16,color: AppColors.THEME_MAIN_COLOR),
                        Container(
                          child: Text("健康线3",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),),
                          margin: EdgeInsets.only(left:5.0),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(top:4.0),
                  ),
                  Text("("+widget.num[2]['lineUserCountActived'].toString()+"/"+widget.num[2]['lineUserCountAll'].toString()+")",style: TextStyle(color: AppColors.THEME_MAIN_COLOR),)
                ],
              ),
              
              //child: Text("123",style: TextStyle(color: Color(0xffB0CD5E)),textAlign: TextAlign.center,),
              height: 50.0,
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0x20B0CD5E),
                borderRadius: BorderRadius.all(Radius.circular(5))
              )
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

//资产统计
class _FinaceData extends StatefulWidget{
  final List list;
  _FinaceData({Key key,this.list}):super(key:key);
  _FinaceDataState createState() => _FinaceDataState();
}
class _FinaceDataState extends State<_FinaceData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("财务数据",style: TextStyle(fontSize: 16.0,color: Color(0xff333333)),textAlign: TextAlign.left,),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset("assets/images/@2xGroup 6.png",height: 50.0,width: 50.0,),
                  Text("硒元素",style: TextStyle(height: 1.5,color: Color(0xff666666)),),
                  Text(widget.list[0],style: TextStyle(height: 1.2,color: Color(0xff666666)),)
                ],
              ),
              Column(
                children: <Widget>[
                  Image.asset("assets/images/@2xxin.png",height: 50.0,width: 50.0,),
                  Text("锌元素",style: TextStyle(height: 1.5,color: Color(0xff666666)),),
                  Text(widget.list[1],style: TextStyle(height: 1.2,color: Color(0xff666666)),)
                ],
              ),
              Column(
                 children: <Widget>[
                  Image.asset("assets/images/@2xwodejifen.png",height: 50.0,width: 50.0,),
                  Text("我的积分",style: TextStyle(height: 1.5,color: Color(0xff666666)),),
                  Text(widget.list[2],style: TextStyle(height: 1.2,color: Color(0xff666666)),)
                ],
              ),
              Column(
                 children: <Widget>[
                  Image.asset("assets/images/@2xaixinjijin.png",height: 50.0,width: 50.0,),
                  Text("爱心基金",style: TextStyle(height: 1.5,color: Color(0xff666666)),),
                  Text(widget.list[3],style: TextStyle(height: 1.2,color: Color(0xff666666)),)
                ],
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _Operation extends StatefulWidget{
  final List list;
  _Operation({Key key,this.list}):super(key:key);
  _OperationState createState() => _OperationState();
}
class _OperationState extends State<_Operation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
           Container(
            child: Text("操作",style: TextStyle(fontSize: 16.0,color: Color(0xff333333)),textAlign: TextAlign.left,),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.0),
          ),
          Wrap(
            runSpacing: 10.0,
            children: <Widget>[
              GestureDetector(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe654,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 40,),
                        Text("元素互转",style: TextStyle(color: Color(0xff666666),height: 1.5))
                      ],
                    ),
                    width: 100.0,
                  ),
                onTap: (){
                  Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EachTurn(datalist: widget.list,)
                          )
                    );
                },
              ),
              GestureDetector(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe658,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 40,),
                        Text("锌元素转账",style: TextStyle(color: Color(0xff666666),height: 1.5))
                      ],
                    ),
                    width: 100.0,
                  ),
                onTap: (){
                  Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TransferAll(listData: widget.list,type: 1)
                          )
                    );
                },
              ),
              GestureDetector(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe657,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 40,),
                        Text("硒元素转账",style: TextStyle(color: Color(0xff666666),height: 1.5))
                      ],
                    ),
                    width: 100.0,
                  ),
                onTap: (){
                  Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TransferAll(listData: widget.list,type: 0)
                          )
                    );
                },
              ),
              GestureDetector(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe655,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 40,),
                        Text("积分转账",style: TextStyle(color: Color(0xff666666),height: 1.5))
                      ],
                    ),
                    width: 100.0,
                  ),
                onTap: (){
                  Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TransferAll(listData: widget.list,type: 2)
                          )
                    );
                },
              ),
              GestureDetector(
                child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(IconData(0xe656,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 40,),
                        Text("收支统计",style: TextStyle(color: Color(0xff666666),height: 1.5))
                      ],
                    ),
                    width: 100.0,
                  ),
                onTap: (){
                  Navigator.push(
                          context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Statistics()
                          )
                    );
                },
              ),
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
