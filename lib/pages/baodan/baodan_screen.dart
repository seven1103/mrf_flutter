import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../../components/pageBox.dart';

import '../../components/head_title.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../service/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/userModel.dart';
import '../../components/my_toast.dart';
import 'createMember.dart';
import '../../models/userinfoModel.dart';

int layer = 0;
class BaodanScreen extends StatefulWidget {
  final UserModel user;
  BaodanScreen({Key key, this.user}) : super(key: key);
  _BaodanScreenState createState() => _BaodanScreenState();
}

// class _BaodanScreenState extends State<BaodanScreen> with AutomaticKeepAliveClientMixin{
//   @override
//   bool get wantKeepAlive => true;
class _BaodanScreenState extends State<BaodanScreen> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  List list = [];
  void initState() { 
    super.initState();
    _getUserTree(widget.user.account);
  }

  void chagelist(List newList){
    // var a = {'a':1,'b':3};
    // a.containsKey(key)

    setState(() {
     list = newList; 
    });
  }

  _getUserTree(String account) async{
    List item = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/user/getUserTree',
        method: HttpUtils.POST,
        data: {
          "account":account,
          "token" :prefs.getString("token")
    },context: context);
    if(response["errcode"] == 200){
      // if(response['result'][0]["account"]!=null){
        
      // }else{
      //   MyToast.showLongToast("暂无下线");
      // }
      for(int i =0 ;i<response['result'].length;i++){
          item.add({
            "usernick":response['result'][i]["nicName"],
            "userAccount":response['result'][i]["account"],
            "imgurl":response['result'][i]["icon"],
            "status":response['result'][i]["state"]=="0",
            "enableFlag":response['result'][i]["enableFlag"],
            "healthLineId":response['result'][i]["healthLineId"],
            "isfirst": true,
            "parentAccount": response['result'][i]["parentAccount"]==null?account:response['result'][i]["parentAccount"],
          });
        }
      setState(() {
        list.add(item); 
      });
    }
  }

 //刷新首页数据
  Future _refresh() async{
    setState(() {
     list = []; 
    });
    _getUserTree(widget.user.account);
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      hastitle: false,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  HeadTitle(title: "报单",user: widget.user),
                  _UserHeader(user:widget.user),
                  _Search(list:list,usercount:widget.user.account,callback: chagelist)
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
              child: Expanded(
                child: RefreshIndicator(
                  color: AppColors.THEME_MAIN_COLOR,
                  onRefresh: _refresh,
                  child: ListView(
                    children: <Widget>[
                      _MemberTab(list:list,callback: chagelist,token: widget.user.token,),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 头部个人信息
class _UserHeader extends StatelessWidget{
  final UserModel user;
  _UserHeader({Key key, this.user}) : super(key: key);

  //图片资源拼接
  String _httpimg(String src) {
    return HttpUtils.IMG_BASEURL + src;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: user.icon!=null?NetworkImage(_httpimg(user.icon)):AssetImage("assets/images/user.png"),
                      radius: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 5.0),                    
                            child: Column(
                              children: <Widget>[
                                Text(user.nickname,style: TextStyle(fontSize: 16.0,color: Colors.white)
                                ),
                                Text(user.account,style: TextStyle(fontSize: 16.0,color: Colors.white))
                              ],
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0),
                          padding: EdgeInsets.all(2.0),
                          child: Text(user.gradeName,style: TextStyle(fontSize: 10.0,color: Colors.white)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                              color: Color(0xffFABC00)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text(user.state=="0"?"状态：正常":"状态：欠费",style: TextStyle(fontSize: 16.0,color: Colors.white)),
                )
              ],
            ),
          );
  }
}

//搜索
class _Search extends StatefulWidget {
  final List list;
  final String usercount;
  final callback;
  _Search({Key key,this.list,this.usercount,this.callback}) : super(key: key);
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  bool showlabel = true;
  TextEditingController TextController = TextEditingController();

  void searchData(String word) async{
    List item = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/user/getChild',
        method: HttpUtils.POST,
        data: {
          "account":widget.usercount,
          "childAccount":word,
          "token" :prefs.getString("token")
    },context: context);
    if(response["errcode"] == 200){
      if(response["result"]==null){
        MyToast.showLongToast("该账号不在你的健康线内");
      }else{
        item.add({
            "usernick":response['result']["nicName"],
            "userAccount":response['result']["account"],
            "imgurl":response['result']["icon"],
            "status":response['result']["state"]=="0",
            "enableFlag":response['result']["enableFlag"],
        });
        item.add({});
        item.add({});
         List returnList = [item];
         widget.callback(returnList);
      }
    }
    // print(word);
    // List returnList = [[{ "usernick":"查询张三","userAccount":"gm001","imgurl": "assets/images/user.png","status":true}]];
    // widget.callback(returnList);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Stack(
         alignment: Alignment.center,
         children: <Widget>[
           showlabel?Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Icon(IconData(0xe643,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffB3B1B1),size: 15),
               Text('   请输入账号',style: TextStyle(color: Color(0xffB3B1B1)))
             ],
           ):Text(''),
           TextField(
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffB3B1B1)),
              keyboardType: TextInputType.number,
              controller: TextController,
              onSubmitted:(a){
                TextController.clear();
                searchData(a);
                setState(() {
                 showlabel =true; 
                });
              },
              onTap: (){
                setState(() {
                 showlabel =false; 
                });
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.2, style: BorderStyle.none)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(style: BorderStyle.none))),
            ),
         ],
       ),
       margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
       //padding: EdgeInsets.all(5.0),
       padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
       decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))
       ),
      
    );
  }
}

// 分支成员tab
class _MemberTab extends StatefulWidget {
   final Widget child;
   final List list;
   final callback;
   final String token;
   _MemberTab({Key key, this.child,this.list,this.callback,this.token}) : super(key: key);
  _MemberTabState createState() => _MemberTabState();
}

class _MemberTabState extends State<_MemberTab> {
  changeData(int layer,String account) async{
    List item = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/user/getUserTree',
        method: HttpUtils.POST,
        data: {
          "account":account,
          "token" :prefs.getString("token")
    },context: context);
    if(response["errcode"] == 200){
      for(int i =0 ;i<response['result'].length;i++){
          item.add({
              "usernick":response['result'][i]["nicName"],
              "userAccount":response['result'][i]["account"],
              "imgurl":response['result'][i]["icon"],
              "status":response['result'][i]["state"]=="0",
              "enableFlag":response['result'][i]["enableFlag"],
              "healthLineId":response['result'][i]["healthLineId"],
              "parentAccount": response['result'][i]["parentAccount"]==null?account:response['result'][i]["parentAccount"],
          });
        }
      if(response['result'][0]["account"]!=null){
        
        
      }else{
        MyToast.showLongToast("暂无下线");
      }
      List returnList = widget.list;
        //判断层级
        if(widget.list.length>layer+1){
            List nlist = [];
            for(int j=0;j<=layer;j++){
              nlist.add(widget.list[j]);
            }
            returnList = nlist;
        }
        returnList.add(item);
        widget.callback(returnList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: buildTabList(widget.list),
      )
      //child: Text("12323"),
    );
  }

  List<Widget> buildTabList(List dataList) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < dataList.length; i++) {
      if(i==dataList.length-1){
        widgetList.add(_MemberTabItem(tabData: dataList[i],callback: changeData,layer: i,isactive: true,token: widget.token,));
      }else{
        widgetList.add(_MemberTabItem(tabData: dataList[i],callback: changeData,layer: i,token: widget.token,));
      }
      
    }
    return widgetList;
  }
}

class _MemberTabItem extends StatefulWidget {
  final Widget child;
  final tabData;
  final int layer;
  final callback;
  final bool isactive;
  final int mywayNum;
  final bool status;
  final String token;
  _MemberTabItem({Key key, this.child,@required this.tabData,this.callback,this.layer=0,this.isactive =false,
  this.mywayNum=0,this.status=true,this.token}) : super(key: key);

  __MemberTabItemState createState() => __MemberTabItemState();
}

class __MemberTabItemState extends State<_MemberTabItem> {
  var userinfo = new UserInfoModel();
  int activenum=0; 
  var lineNames = ['线路一','线路二','线路三'];
  //点击查看用户信息
  _generateAlertDialog(String account) async{
    _cleardata();
    await _getinfo(account);
    await _getasset(account);
    await _getline(account);
    showDialog(context: context, builder: (_) =>
      SimpleDialog(
        //title: Text('这是标题'),
        contentPadding: EdgeInsets.all(10.0),
        shape: BeveledRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10.0))),
        children: <Widget>[
          Container(
            //height: 300,
            child: Container(
              child: Column(
                children: <Widget>[
                    Container(
                      child:  Row(
                        children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                backgroundImage:userinfo.icon==null?AssetImage("assets/images/user.png"):NetworkImage(_httpimg(userinfo.icon)),
                                radius: 25,
                              ),
                              margin: EdgeInsets.only(right: 10.0),
                            ),
                            Column(
                              children: <Widget>[
                                Text(userinfo.nickname,style: TextStyle(color: Color(0xff666666),fontSize: 16.0)),
                                Text('创建时间：'+formatDate(DateTime.parse(userinfo.createDate), [yyyy, '-', mm, '-', dd, '']),
                                style: TextStyle(color: Color(0xff999999),fontSize: 12.0))
                              ],
                            )
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
                      ),
                    ),
                   _MineItem(title: "会员状态",trailing: '正常',trailingIcon: false),
                   _MineItem(title: "账       号",trailing: userinfo.account,trailingIcon: false),
                   _MineItem(title: "积       分",trailing: userinfo.assetsJifen,trailingIcon: false),
                   _MineItem(title: "硒  元  素",trailing: userinfo.assetsXi,trailingIcon: false),
                   _MineItem(title: "锌  元  素",trailing: userinfo.assetsXin,trailingIcon: false),
                   _MineItem(title: "线  路  一",trailing: userinfo.line1,trailingIcon: false),
                   _MineItem(title: "线  路  二",trailing: userinfo.line2,trailingIcon: false),
                   _MineItem(title: "线  路  三",trailing: userinfo.line3,trailingIcon: false),
                ],
              ),
            )
          ),
          FlatButton(
            child: Text('关闭'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      )
    );
  }
  //获取个人信息
  _getinfo(String account) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request("/user/userInfo",
      method: HttpUtils.POST,
      data: {
        "account": account,
        "token": prefs.getString('token')
      },
      //context: context
    );
    if(response['errcode']==200){
      var result = response['result'];
      userinfo.account = result['account'];
      userinfo.nickname = result['nicName'];
      userinfo.state = result['state'];
      userinfo.createDate = result['createDate'];
      userinfo.icon = result['icon'];
    }
  }
  //获取个人资产
  _getasset(String account) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/asset/select',
        method: HttpUtils.POST,
        data: {
          "account":account,
          "token" :prefs.getString('token')
    },
    //context: context
    );
    if(response['errcode']==200){
      var result = response['result'];
      userinfo.assetsXi = result[0]['value'].toString();
      userinfo.assetsXin = result[1]['value'].toString();
      userinfo.assetsJifen = result[2]['value'].toString();
    }
  }
  //获取个人健康线
  _getline(String account) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/line/lineUserCount',
        method: HttpUtils.POST,
        data: {
          "account":account,
          "token" :prefs.getString('token')
    },
    //context: context
    );
    if(response['errcode']==200){
      var result = response['result'];
      //print(result[0]['lineUserCountActived'].toString());
      userinfo.line1 = result[0]['lineUserCountActived'].toString()+'/'+result[0]['lineUserCountAll'].toString();
      userinfo.line2 = result[1]['lineUserCountActived'].toString()+'/'+result[1]['lineUserCountAll'].toString();
      userinfo.line3 = result[2]['lineUserCountActived'].toString()+'/'+result[2]['lineUserCountAll'].toString();
    }
  }
  //清空数据
  void _cleardata(){
    userinfo.account = '';
    userinfo.nickname = '';
    userinfo.state = '';
    userinfo.createDate = '';
    userinfo.icon = '';
  }
  String _httpimg(String src){
    return HttpUtils.IMG_BASEURL + src;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         children: buildList(widget.tabData)
       ),
       padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0)
    );
  }

  List<Widget> buildList(List dataList){
    List<Widget> widgetList = new List();
    for (int i = 0; i < dataList.length; i++) {
      widgetList.add(
        Expanded(
             flex: 1,
             child: Container(
                child: dataList[i]["userAccount"]!=null?GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: dataList[i]["imgurl"]==null?AssetImage("assets/images/user.png"):NetworkImage(_httpimg(dataList[i]["imgurl"])),
                                          radius: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(dataList[i]["usernick"],style: TextStyle(color: Color(0xff333333),fontSize: 14.0,)),
                                              Text(dataList[i]["userAccount"],style: TextStyle(color: Color(0xff808080),fontSize: 10.0,height: 1.2),),
                                              Text(dataList[i]["status"]?"状态：正常":"状态：停用",style: TextStyle(color: AppColors.THEME_MAIN_COLOR,fontSize: 10.0,height: 1.5),),
                                            ],
                                          ),
                                        )
                                        
                                      ],
                                    ),
                                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0))
                                    ),
                                  ),
                                  onTap: (){
                                    _generateAlertDialog(dataList[i]["userAccount"]);
                                  },
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(lineNames[i],style: TextStyle(color: activenum==i+1&&widget.isactive==false?Colors.white:AppColors.THEME_MAIN_COLOR,fontSize: 13.0),),
                                  width: double.infinity,
                                  height: 40.0,
                                  margin: EdgeInsets.only(bottom: 5.0),
                                  decoration: BoxDecoration(
                                    color: activenum==i+1&&widget.isactive==false?AppColors.THEME_MAIN_COLOR:Colors.white,
                                    border: Border.all(color: AppColors.THEME_MAIN_COLOR),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0))
                                  ),
                                  
                                ),
                              ],
                          ),
                          !dataList[i]["status"]?Container(
                            child: Text(""),
                            color: Color(0x55000000),
                            width: double.infinity,
                            height: 78,
                          ):Text("")
                        ],
                      ),
                      Container(
                          child: Icon(IconData(0xe63c,fontFamily: Constants.ICON_FONT_FAMILY),
                          color: activenum==i+1&&widget.isactive==false?Colors.black:Colors.transparent,size: 20.0,)
                      ),
                    ],
                  ),
                  onTap: (){
                   setState(() {
                    activenum = i+1; 
                   });
                   widget.callback(widget.layer,dataList[i]["userAccount"]);
                  },
                ):dataList[i]['enableFlag']=='1'?_createMember(type: i+1,healthLineName: lineNames[i],isfirst: true,healthLineId:dataList[i]["healthLineId"],parentAccount: dataList[i]['parentAccount'],):Text(''),
                padding: EdgeInsets.only(right: 5.0),
             )
        )
      );
    }
    return widgetList;
  }
}


class _createMember extends StatelessWidget {
  final String healthLineName;
  final int type;
  final bool isfirst;
  final String healthLineId;
  final String parentAccount;
  _createMember({Key key, this.healthLineName,this.type,this.isfirst,this.healthLineId,this.parentAccount}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/user.png"),
                            radius: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("昵称",style: TextStyle(color: Color(0xff333333),fontSize: 14.0,)),
                                Text("账号",style: TextStyle(color: Color(0xff808080),fontSize: 10.0,height: 1.2),),
                                Text("状态：正常",style: TextStyle(color: Colors.transparent,fontSize: 10.0,height: 1.5),),
                              ],
                            ),
                          )
                          
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0))
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(healthLineName,style:TextStyle(color: AppColors.THEME_MAIN_COLOR,fontSize: 13.0)),
                      width: double.infinity,
                      height: 40.0,
                      margin: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border: Border.all(color: AppColors.THEME_MAIN_COLOR),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0))
                      ),
                    ),
                  ],
              ),
              Container(
                child: Text(""),
                color: Color(0x55000000),
                width: double.infinity,
                height: 78,
              ),
              isfirst!=null?Positioned(
                top:30.0,
                left: 20.0,
                child: Row(
                  children: <Widget>[
                    Icon(IconData(0xe631,fontFamily: Constants.ICON_FONT_FAMILY),color: Colors.white,),
                    Text("创建账户",style: TextStyle(color:Colors.white),)
                  ],
                ),
              ):Text('')
            ],
          ),
          Container(
              child: Icon(IconData(0xe63c,fontFamily: Constants.ICON_FONT_FAMILY),color: Colors.transparent,size: 20.0,)
          )
        ],
      ),
      onTap: (){
        if(isfirst){
          Navigator.push(context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CreateMember(type:type,healthLineId:healthLineId,parentAccount:parentAccount)
                )
          );
        }
      }
    );
  }
}

class _MineItem extends StatelessWidget {
  final String title;
  final String trailing;
  final bool trailingIcon;
  final bool isend;
  final callback;
  _MineItem({Key key,  
    @required this.title,
    this.trailing = "",
    this.trailingIcon = true,
    this.isend = false,
    this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title+":"),
              Row(
                children: <Widget>[
                  Text(trailing),
                  Container(
                    child: trailingIcon? Icon(IconData(0xe635,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffcccccc),size: 16.0,):null,
                  )
                ],
              )
            ],
          ),
          
        ),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
        ),
      ),
      onTap: (){
        callback(title);
        //Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>callback));
      },
    );
  }

  //_MineItemState createState() => _MineItemState();
}