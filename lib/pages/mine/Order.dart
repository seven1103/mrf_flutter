import 'package:flutter/material.dart';

import '../../components/pageBox.dart';

import '../../data/constants.dart' show AppColors,Constants;

class CommodityOrders extends StatefulWidget {
  _CommodityOrdersState createState() => _CommodityOrdersState();
}

class _CommodityOrdersState extends State<CommodityOrders>
    with SingleTickerProviderStateMixin {
  TabController mController;
  List<Tab> tabs;
  List<Widget> tabViews;
  @override
  void initState() {
    super.initState();
    tabs = [
      Tab(text: "全部"),
      Tab(text: "待付款"),
      Tab(text: "待发货"),
      Tab(text: "待收货"),
      Tab(text: "待评价")
    ];
    tabViews = [
      _AllOrder(),
      _AmountOutstanding(),
      _ToBeShipped(),
      _ToBeReceived(),
      _ToBeEvaluated()
    ];
    mController = TabController(
      // initialIndex: 3,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "我的订单",
      // body: Center(
      //   child: Container(
      //     child: Column(
      //       // mainAxisSize: MainAxisSize.max,
      //       // crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Icon(IconData(0xe62f,fontFamily: Constants.ICON_FONT_FAMILY),size: 50,color: Color(0xff999797),),
      //         Text("版本升级中",style: TextStyle(color: Color(0xff999797),fontSize: 20),)
      //       ],
      //     ),
      //     margin: EdgeInsets.only(top:200.0),
      //   ),
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: TabBar(
                tabs: tabs,
                controller: mController,
                isScrollable: true,
                labelColor: AppColors.ACCENTCOLOR_FONT_COLOR,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColors.THEME_COLOR,
              ),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10))),
              width: double.infinity,
            ),
            Expanded(
              child: TabBarView(
                controller: mController,
                children: tabViews,
              ),
            )
          ],
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
    );
  }
}

class _AllOrder extends StatefulWidget {
  _AllOrderState createState() => _AllOrderState();
}

class _AllOrderState extends State<_AllOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: ClipRRect(
                          child: Image.network(
                              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549947658087&di=80329041dd1323c7950fb151988d9072&imgtype=0&src=http%3A%2F%2Fimg2.spzs.com%2Fgroup1%2FM00%2F26%2F0B%2FcnHoeVooFlaAAMngAADO165mJ0s619.jpg",
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: EdgeInsets.only(right: 10),
                        width: 100,
                        height: 105,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("侗坊淳元野山茶籽油/术后康复优选/家庭食用油",
                                style: TextStyle(
                                    color: AppColors.ACCENTCOLOR_FONT_COLOR,
                                    fontSize: 16)),
                            Container(
                              child: Text("×1",
                                  style: TextStyle(
                                      color: AppColors.DEFAULT_FONT_COLOR,
                                      fontSize: 12)),
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("¥ 269.00",
                                        style: TextStyle(
                                            color: Color(0xffFF4A53),
                                            fontSize: 18)),
                                  ),
                                  Text("待付款",
                                      style: TextStyle(
                                          color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                                          fontSize: 12))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("合计：¥ 269.00",style: TextStyle(
                          fontSize:14,
                          color: Colors.black ,
                          fontWeight: FontWeight.w300
                        ))
                      ),
                      Container(
                        child: OutlineButton(
                          child: Text("取消订单",style: TextStyle(
                            fontSize: 14,
                            color: AppColors.SECONDARYCOLOR_FONT_COLOR
                          )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          highlightedBorderColor: AppColors.SECONDARYCOLOR_FONT_COLOR,
                          highlightElevation: 0,
                          borderSide: BorderSide(
                            color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                            width: 0.5,
                          ),
                          padding: EdgeInsets.all(0),
                          onPressed: () async {},
                        ),
                        height: 30,
                        width: 80,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Container(
                        child: OutlineButton(
                          child: Text("去付款",style: TextStyle(
                            fontSize: 14,
                            color: AppColors.THEME_COLOR
                          )),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          highlightedBorderColor: AppColors.THEME_COLOR,
                          highlightElevation: 0,
                          borderSide: BorderSide(
                            color: AppColors.THEME_COLOR,
                            width: 0.5,
                          ),
                          padding: EdgeInsets.all(0),
                          onPressed: () async {},
                        ),
                        height: 30,
                        width: 80,
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10),
                )
              ],
            ),
            color: Colors.white,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
          ),
        ],
      ),
    );
  }
}

class _AmountOutstanding extends StatefulWidget {
  _AmountOutstandingState createState() => _AmountOutstandingState();
}

class _AmountOutstandingState extends State<_AmountOutstanding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("AmountOutstanding"),
    );
  }
}

class _ToBeShipped extends StatefulWidget {
  _ToBeShippedState createState() => _ToBeShippedState();
}

class _ToBeShippedState extends State<_ToBeShipped> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ToBeShipped"),
    );
  }
}

class _ToBeReceived extends StatefulWidget {
  _ToBeReceivedState createState() => _ToBeReceivedState();
}

class _ToBeReceivedState extends State<_ToBeReceived> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ToBeReceived"),
    );
  }
}

class _ToBeEvaluated extends StatefulWidget {
  _ToBeEvaluatedState createState() => _ToBeEvaluatedState();
}

class _ToBeEvaluatedState extends State<_ToBeEvaluated> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ToBeEvaluated"),
    );
  }
}
