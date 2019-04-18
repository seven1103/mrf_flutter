import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../components/pageBox.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../components/head_title.dart';
import '../../models/userModel.dart';
import './store_detail.dart';
class StoreScreen extends StatefulWidget {
  final UserModel user;
  StoreScreen({Key key, this.user}) : super(key: key);
  _StoreScreenState createState() => _StoreScreenState();
}
class _StoreScreenState extends State<StoreScreen> {
  List list = new List();
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int _page = 1; //加载的页数
  int _tabindex = 1;
  bool isLoading = false; //是否正在加载数据

  @override
  void initState() { 
    super.initState();
    _refresh();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print('滑动到最低部');
        _getMore();
      }
    });
  }

  Future _refresh() async{
    await Future.delayed(Duration(seconds:3),(){
      print('数据已更新');
      setState(() {
        list = List.generate(4, (i)=>'我是原始数据$i');
      });
    });
  }

  Future _getMore() async{
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1), () {
        print('加载更多');
        setState(() {
          list.addAll(List.generate(5, (i) => '第$_page次上拉来的数据'));
          _page++;
          isLoading = false;
        });
        print(list.length);
      });
    }
  }

  void tabload(tabindex) {
    print("当前分类是$tabindex");
    setState(() {
      _tabindex = tabindex;
      list = [];
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      hastitle: false,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: HeadTitle(title: "铭润福商城",user: widget.user,),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/page_header.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.center
                    )
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                //轮播图模块
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150.0,
                        child: Swiper(
                          itemBuilder: _swiperBuilder,
                          itemCount: 3,
                          pagination: new SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              color: Color(0xffcccccc),
                              activeColor: Colors.white,
                            ),
                            margin: EdgeInsets.only(bottom: 20.0)
                          ),
                          //control: new SwiperControl(),
                          scrollDirection: Axis.horizontal,
                          autoplay: true,
                          onTap: (index)=>print('点击了第$index个'),
                        ),
                      ),
                      Container(
                        child: Text(''),
                        height: 70.0,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context,int index){
                        return _tabItem(context,index);
                      },
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  height: 80.0,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                )
              ],
            ),
            Container(
               child: Expanded(
                  child: RefreshIndicator(
                    color: AppColors.THEME_MAIN_COLOR,
                    onRefresh: _refresh,
                    child: ListView(
                      controller: _scrollController,
                      children: <Widget>[
                        Container(
                          child: Wrap(
                            spacing: 18.0, // gap between adjacent chips
                            runSpacing: 10.0, 
                            children: buildList(context,list)
                          ),
                          margin: EdgeInsets.only(left: 20.0),
                        )
                      ],
                    )
                )
               ),
            )
          ]
      )
    )
  );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://via.placeholder.com/350x150",
      fit: BoxFit.fill,
    ));
  }

  //tabitem
  var tabname = ['口服液','土特产','手工艺','养生'];
  Widget _tabItem(BuildContext context,int index) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            tabname.length>index?Image.asset('assets/images/store_tab'+(index+1).toString()+'.png',height: 40.0):Text('暂无图片'),
            Text(tabname.length>index?tabname[index]:'待命名$index',style: TextStyle(color: _tabindex==index+1?AppColors.THEME_MAIN_COLOR:Color(0xff999797),fontSize: 14.0),)
          ],
        ),
        width: 80.0,
        height: 80.0,
      ),
      onTap: (){
        tabload(index+1);
      },
    );
  }

  //商品item
  Widget _shopItem(BuildContext context,int index){
    return GestureDetector(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(''),
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/good.png"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center
                  )
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Text('锌硒口服液2312312312312',style: TextStyle(color: Color(0xff333333),fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                          width: 120.0,
                        ),
                        GestureDetector(
                          child: Icon(IconData(0xe651,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffff404a),size: 24.0,),
                          onTap: (){
                            print('进入购物车$index');
                          },
                        )
                        
                      ],
                    ),
                    Container(
                      child: Text("￥168+50积分",style: TextStyle(color: Color(0xffff404a),fontSize: 14.0)),
                      width: double.infinity,
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 5.0),
              )
            ],
          ),
        width: 150.0,
        height: 200.0,
        color: Colors.white
      ),
      onTap: (){
        print('进入商品详情页$index');
         Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => storeDetail()));
      },
    );
  }

  List<Widget> buildList(BuildContext context,List dataList){
    List<Widget> widgetList = new List();
    for (int i = 0; i < dataList.length; i++) {
      widgetList.add(_shopItem(context,i));
    }
    return widgetList;
  }
}
