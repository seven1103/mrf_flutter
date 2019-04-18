import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/pageBox.dart';
import '../../data/constants.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../service/config.dart';
import '../../components/my_toast.dart';
import 'package:date_format/date_format.dart';

class Statistics extends StatefulWidget {
  final Widget child;

  Statistics({Key key, this.child}) : super(key: key);

  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with SingleTickerProviderStateMixin {
  TabController mController;
  int activetab;
  int listtype;
  List tablist1;
  List tablist2;

  @override
  void initState() {
    super.initState();
    mController = TabController(
      length: tabs.length,
      vsync: this,
    );
    tablist1 = [];
    tablist2 = [];
    listtype = 0;
    activetab = 0;
    getlist('0','1');
    getlist('1','1');
  }
  
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }
  var tabs = <Tab>[
    Tab(text: "我的收益"),
    Tab(text: "消费支出"),
  ];

  @override
  void ActiveChange(type){
    //print('切换状态');
    setState(() {
     listtype = type;
    activetab = mController.index;
    getlist(activetab.toString(),listtype.toString()); 
    });
  }

  void getlist(String tabindex,String classtype) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/bills/select',
        method: HttpUtils.POST,
        data: {
          "account":prefs.getString('account'),
          "curMonth": classtype,
          "token" : prefs.getString('token'),
          "type": tabindex
    },context: context);
    if(response['errcode']==200){
      if(tabindex=='0'){
        setState(() {
         tablist1 = [];
          tablist1 = response['result']; 
        });
      }else{
        setState(() {
          tablist2 = [];
          tablist2 = response['result'];
        });
      }
    }else{
      MyToast.showShortToast(response['errmsg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "收支统计",
      body: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  height: 40.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: AppColors.THEME_MAIN_COLOR,
                    //是否可以滚动
                    controller: mController,
                    labelColor: Colors.red,
                    unselectedLabelColor: Color(0xff666666),
                    labelStyle: TextStyle(fontSize: 12.0),
                    tabs: tabs.map((item) {
                      if(item.text=="我的收益"){
                        return Tab(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(IconData(0xe649,fontFamily: Constants.ICON_FONT_FAMILY,),color: AppColors.THEME_MAIN_COLOR),
                                  margin: EdgeInsets.only(right: 10.0),
                                ),
                                Text(item.text)
                              ],
                            ),                  
                          ),
                        );
                      }else{
                        return Tab(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(IconData(0xe64d,fontFamily: Constants.ICON_FONT_FAMILY,),color: AppColors.THEME_MAIN_COLOR),
                                  margin: EdgeInsets.only(right: 10.0),
                                ),
                                Text(item.text)
                              ],
                            ),                  
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        child: Text("全部",style:TextStyle(color: listtype==0?Colors.white:AppColors.THEME_MAIN_COLOR)),
                        onPressed: (){ActiveChange(0);},
                        color: listtype==0?AppColors.THEME_MAIN_COLOR:Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 10.0),
                      width: 65.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.THEME_MAIN_COLOR),
                        //borderRadius: BorderRadius.all(Radius.circular(3.0))
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: Text("本月",style:TextStyle(color: listtype==1?Colors.white:AppColors.THEME_MAIN_COLOR)),
                        onPressed: (){ActiveChange(1);},
                        color: listtype==1?AppColors.THEME_MAIN_COLOR:Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 10.0),
                      width: 65.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.THEME_MAIN_COLOR)
                      ),
                    )
                    
                  ],
                ),
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                color: Colors.white,
              ),
              Expanded(
                child: TabBarView(
                  controller: mController,
                  children: <Widget>[
                     _View(tabindex: '0',classtype: listtype.toString(),list: tablist1,callback: getlist),
                     _View(tabindex: '1',classtype: listtype.toString(),list: tablist2,callback: getlist)
                  ],
                ),
                
              )
            ],
          ),
      );

  }
}

class _View extends StatefulWidget {
  final List list;
  final String tabindex;
  final String classtype;
  final Function callback;
  _View({Key key, this.tabindex,this.classtype,this.callback,this.list}) : super(key: key);
  _ViewState createState() => _ViewState();
}
class _ViewState extends State<_View> {
  void initState() { 
    super.initState();
  }
   Future<Null> _onRefresh() async{
       await widget.callback(widget.tabindex,widget.classtype);
  }
  String formdata(String date){
    return formatDate(DateTime.parse(date), [yyyy, '年', mm, '月', dd, '日']);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RefreshIndicator(
          color: AppColors.THEME_MAIN_COLOR,
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (BuildContext context,int index){
              if(widget.tabindex=='0'){
                return _item(type: widget.list[index]['incomeType'],text: widget.list[index]['name'],date:formdata(widget.list[index]['createTime']),number: widget.list[index]['amount'].toString());
              }else{
                return _item(type: widget.list[index]['payType'],text: widget.list[index]['name'],date:formdata(widget.list[index]['createTime']),number: '-'+widget.list[index]['amount'].toString());
              }
            },
        ),
        ),
      //  child: ListView(
      //    children: <Widget>[
      //      _item(type: 1,text: "收到锌元素转账",date:"昨天 22:01",number: "100",),
      //      _item(type: 2,text: "收到硒元素转账",date:"昨天 22:01",number: "100",),
      //      _item(type: 3,text: "积分收益",date:"昨天 22:01",number: "100",),
      //      _item(type: 4,text: "平台收益",date:"昨天 22:01",number: "100",),
      //    ],
      //  ),
        
    );
  }
}

// type类型
// 锌元素转账  01
// 硒元素转账  02
// 积分收益    03
// 平台收益    04
// 购买金额    05
// 购买话费积分 06







class _item extends StatefulWidget {
  final Widget child;
  final String type;
  final String text;
  final String date;
  final String number;

  _item({Key key, this.child, this.type,this.text, this.date, this.number}) : super(key: key);

  _itemState createState() => _itemState();
}

class _itemState extends State<_item> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         child: Container(
           child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icontype(type: widget.type),
                          margin: EdgeInsets.only(right: 10.0),
                        ),
                        Expanded(child: Column(
                          
                          children: <Widget>[
                            Container(
                              child: Text(widget.text),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              child: Text(widget.date,style: TextStyle(color: Color(0xff999797),fontSize: 12.0),),
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),)
                      ],
                    ),
                  ),
                ),
                Text(widget.number)             
              ],
            ),
          width: double.infinity,
           padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
           decoration: BoxDecoration(
             border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
           ),
         ),
       ),
       width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }
}

class Icontype extends StatelessWidget {
  final Widget child;
  final String type;
  
  Icontype({Key key, this.child,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int code;
    int color;
    switch (type) {
      case '01':
        code = 0xe657;
        color = 0xffA2A8FF;
        break;
      case '02':
        code = 0xe658;
        color = 0xffB0CD5E;
        break;
      case '03':
        code = 0xe656;
        color = 0xffFABC00;
        break;
      case '04':
        code = 0xe650;
        color = 0xffF5A623;
        break;
      case '05': 
        code = 0xe651;
        color = 0xffFF404A;
        break;
      case '06':
        code = 0xe658;
        color = 0xffFABC00;
        break;
      default:
    }
    return Container(
      child: Icon( IconData(code,fontFamily: Constants.ICON_FONT_FAMILY),size: 40.0,color: Color(color),),
    );
  }
}
// 锌元素转账  01
// 硒元素转账  02
// 积分收益    03
// 平台收益    04