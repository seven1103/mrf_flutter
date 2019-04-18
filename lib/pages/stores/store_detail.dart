import 'package:flutter/material.dart';
import '../../components/pageBox.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../data/constants.dart' show Constants, AppColors;
import './photo_view.dart';
import './store_buy.dart';
import '../mine/ShopCart.dart'; 
class storeDetail extends StatefulWidget {
  @override
  _storeDetailState createState() => _storeDetailState();
}

class _storeDetailState extends State<storeDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<Widget> commodityInfo =List();
  List<Image> commodityPic = List();
  Map commodityIntro = {};
  Map commodityParam = {};
  String commodityDetails = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _getDetail();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getDetail() async{
    commodityPic.add(Image.asset('assets/images/good.png',fit: BoxFit.fill));
    commodityPic.add(Image.asset('assets/images/good.png',fit: BoxFit.fill));
    commodityPic.add(Image.asset('assets/images/good.png',fit: BoxFit.fill));
    commodityInfo.add(_CommodityWindow(pic:commodityPic));
    commodityInfo.add(_CommodityInfo());
    commodityInfo.add(_CommodityDetails());
  }

  @override
  Widget build(BuildContext context) {
     return PageBox(
       title: '商品详情页',
       body: Container(
         child: Container(
           child: Column(
             children: <Widget>[
               Expanded(
                 child: Container(
                  child: ListView.builder(
                    itemCount: commodityInfo.length,
                    itemBuilder: (BuildContext context,int index) => commodityInfo[index],
                  ),
                 ),
               ),
               Container(
                 child: Row(
                   children: <Widget>[
                     Expanded(
                       child: Container(
                         child: FlatButton(
                           child: Column(
                             children: <Widget>[
                               Container(
                                 child: Icon(IconData(0xe651,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xff999797),size: 24.0,),
                                 margin: EdgeInsets.only(top: 5.0),
                               ),
                               Text('购物车',style: TextStyle(color: Color(0xff999797),fontSize: 12.0),)
                             ],
                           ),
                          onPressed: (){
                            print('进入购物车');
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ShopipingCart()));
                          },
                         ),
                         height: 50,
                       ),
                       
                     ),
                     // 加入购物车
                     Expanded(
                       child: Container(
                          child: FlatButton(
                            child: Text("加入购物车",
                                style:
                                    TextStyle(color: AppColors.THEME_MAIN_COLOR, fontSize: 16)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                side: BorderSide(color: AppColors.THEME_MAIN_COLOR)
                            ),
                            onPressed: () async {
                              // showDialog(
                              //     context: context,
                              //     barrierDismissible: false,
                              //     builder: (BuildContext context) {
                              //       return _CommoditySpecificationsDialog();
                              //     });
                              print('已加入购物车');
                            },
                          ),
                          height: 40,
                          //margin: EdgeInsets.only(right: 10.0),
                        ),
                     ),
                     Container(
                       width: 10.0,
                     ),
                      //  立即购买
                     Expanded(
                        child: Container(
                          child: FlatButton(
                            child: Text("立即购买",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40.0))
                            ),
                            color: AppColors.THEME_MAIN_COLOR,
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return _CommoditySpecificationsDialog();
                                  });
                            },
                          ),
                          height: 40,
                        ),
                      ), 
                     Container(
                       width: 10.0,
                     ),
                   ],
                 ),
                 decoration: BoxDecoration(
                  color: Colors.white,
                  ),
               )
             ],
           ),
         ),
       ),
     );
  }
}

//  商品轮播窗口
class _CommodityWindow extends StatefulWidget {
  final List<Image> pic;
  _CommodityWindow({Key key,@required this.pic})
  :assert(pic != null),
  super(key:key);
  _CommodityWindowState createState() => _CommodityWindowState();
}

class _CommodityWindowState extends State<_CommodityWindow> {
  SwiperController _swiperController;
  int _index = 1;
  @override
  void initState() {
    super.initState();
    _swiperController = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              //  轮播窗口
              Swiper(
                loop: false,
                controller: _swiperController,
                itemBuilder: (BuildContext context, int index) {
                  return widget.pic[index];
                },
                itemCount: widget.pic.length,
                onIndexChanged: (index) {
                  setState(() {
                    _index = index + 1;
                  });
                },
                onTap: (index) async {
                  Navigator.push<int>(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              new PhotoView(index: index))).then((int index) {
                    _swiperController.move(index);
                  });
                },
              ),
              Container(
                child: Text("$_index/" + widget.pic.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
              )
            ],
          )),
      height: 200,
      width: double.infinity,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    );
  }
}
//  商品信息
class _CommodityInfo extends StatefulWidget {
  @override
  __CommodityInfoState createState() => __CommodityInfoState();
}

class __CommodityInfoState extends State<_CommodityInfo>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text('【锌硒口服液】专注儿童健康，健康优选50ML'),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("价格：￥168+50积分",style: TextStyle(color: Color(0xffff404a),fontSize: 16.0)),
              Text("产地 贵州贵阳",style: TextStyle(color: Color(0xff666666),fontSize: 12.0))
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('运费 ￥0',style: TextStyle(color: Color(0xff666666),fontSize: 12.0)),
                Text('销量 187',style: TextStyle(color: Color(0xff666666),fontSize: 12.0)),
                Text('库存 327',style: TextStyle(color: Color(0xff666666),fontSize: 12.0)),
              ],
            ),
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xfff7f7f7),width: 0.5))
            ),
          )
        ],
      ),
      color: Colors.white,
      padding: EdgeInsets.all(10),
    );
  }
}
//  商品图片详情
class _CommodityDetails extends StatefulWidget {
  @override
  __CommodityDetailsState createState() => __CommodityDetailsState();
}

class __CommodityDetailsState extends State<_CommodityDetails>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 1,
                  color: Color(0xffe6e6e6),
                  margin: EdgeInsets.only(right: 10.0),
                ),
                Container(
                  child: Text('商品详情',style: TextStyle(color: Color(0xff999797)),),
                ),
                Container(
                  width: 50.0,
                  height: 1,
                  color: Color(0xffe6e6e6),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
            margin: EdgeInsets.all(10.0),
          ),
          Container(
            child: Column(
              children: ImageList(context,[1,2,3,4]),
            ),
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          )
        ],
      ),
    );
  }

  List<Widget> ImageList(BuildContext context,List dataList){
    List<Widget> widgetList = new List();
    for (int i = 0; i < dataList.length; i++) {
      widgetList.add(Image.asset('assets/images/good.png',fit: BoxFit.fill));
    }
    return widgetList;
  }
}

// 加入购物车
//  商品选择规格Dialog
class _CommoditySpecificationsDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: _SpecificationsBox(),
    );
  }
}

class _SpecificationsBox extends StatefulWidget {
  _SpecificationsBoxState createState() => _SpecificationsBoxState();
}

class _SpecificationsBoxState extends State<_SpecificationsBox> {
  int cnum;
  void initState() {
    super.initState();
    cnum = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  //  商品图片                                  
                                  Container(
                                    child: ClipRRect(
                                      child: Image.network(
                                          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549947658087&di=80329041dd1323c7950fb151988d9072&imgtype=0&src=http%3A%2F%2Fimg2.spzs.com%2Fgroup1%2FM00%2F26%2F0B%2FcnHoeVooFlaAAMngAADO165mJ0s619.jpg",
                                          fit: BoxFit.cover),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    width: 100,
                                    height: 110,
                                    margin: EdgeInsets.all(10),
                                  ),
                                  
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //  价格
                                        Container(
                                          child: Text("价格：￥168+50积分",
                                              style: TextStyle(
                                                  color: Color(0xffFF4A53),
                                                  fontSize: 18)),
                                          margin: EdgeInsets.only(bottom: 8),
                                        ),
                                        //  库存、已售
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              //  库存
                                              Container(
                                                child: Text("库存：1245",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .DEFAULT_FONT_COLOR,
                                                      fontSize: 12,
                                                    )),
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                              ),
                                              //  已售
                                              Container(
                                                child: Text("已售：1245",
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .DEFAULT_FONT_COLOR,
                                                      fontSize: 12,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(bottom: 8),
                                        ),
                                        //  积分
                                       
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text("选择规格",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            ),
                            //  规格
                            Container(
                              child: Row(
                                children: <Widget>[
                                  //  规格项
                                  Container(
                                    child: OutlineButton(
                                      child: Text("500ML",
                                          style: TextStyle(
                                              color: AppColors.THEME_MAIN_COLOR,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300)),
                                      onPressed: () async {},
                                      padding: EdgeInsets.all(0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.THEME_MAIN_COLOR),
                                      splashColor: Color(0xffFFF1E8),
                                      highlightElevation: 0.0,
                                      highlightColor: Color(0xffFFF1E8),
                                      highlightedBorderColor:
                                          AppColors.THEME_COLOR,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    width: 45,
                                    height: 25,
                                    color: Color(0xffFFF1E8),
                                    margin: EdgeInsets.only(right: 10),
                                  ),
                                  Container(
                                    child: OutlineButton(
                                      child: Text("5L",
                                          style: TextStyle(
                                              color:
                                                  AppColors.DEFAULT_FONT_COLOR,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300)),
                                      onPressed: () async {},
                                      padding: EdgeInsets.all(0),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.UNDERLINE_COLOR),
                                      splashColor: AppColors.UNDERLINE_COLOR,
                                      highlightElevation: 0.0,
                                      highlightColor: AppColors.UNDERLINE_COLOR,
                                      highlightedBorderColor:
                                          AppColors.UNDERLINE_COLOR,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    width: 45,
                                    height: 25,
                                    color: AppColors.UNDERLINE_COLOR,
                                    margin: EdgeInsets.only(right: 10),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: AppColors.UNDERLINE_COLOR))),
                            ),
                            //  数量
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("购买数量",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: FlatButton(
                                            child: Text("-",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors
                                                        .DEFAULT_FONT_COLOR)),
                                            color: AppColors.UNDERLINE_COLOR,
                                            highlightColor:
                                                AppColors.UNDERLINE_COLOR,
                                            splashColor:
                                                AppColors.UNDERLINE_COLOR,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0))),
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              setState(() {
                                                cnum = cnum == 1 ? 1 : cnum - 1;
                                              });
                                            },
                                          ),
                                          width: 20,
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text("$cnum",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors
                                                      .DEFAULT_FONT_COLOR)),
                                          width: 40,
                                        ),
                                        Container(
                                          child: FlatButton(
                                            child: Text("+",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors
                                                        .DEFAULT_FONT_COLOR)),
                                            color: AppColors.UNDERLINE_COLOR,
                                            highlightColor:
                                                AppColors.UNDERLINE_COLOR,
                                            splashColor:
                                                AppColors.UNDERLINE_COLOR,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0))),
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              setState(() {
                                                cnum++;
                                              });
                                            },
                                          ),
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(10),
                            )
                          ],
                        ),
                      ),
                      //  返回
                      Container(
                        child: GestureDetector(
                          child: Icon(
                            IconData(0xe63d,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            color: Color(0xffE2E2E2),
                            size: 18,
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                      )
                    ],
                  ),
                )
              ],
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            margin: EdgeInsets.only(bottom: 5),
          ),
          // 确定按钮
          Container(
            child: FlatButton(
              child: Text("确定",
                  style: TextStyle(color: AppColors.THEME_MAIN_COLOR, fontSize: 18)),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              onPressed: () async {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ConfirmOrder()));
              },
            ),
            width: double.infinity,
            height: 50,
          )
        ],
      ),
    );
  }
}