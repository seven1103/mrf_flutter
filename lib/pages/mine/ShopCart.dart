import 'package:flutter/material.dart';

import '../../components/pageBox.dart';

import '../../data/constants.dart' show AppColors, Constants;

class ShopipingCart extends StatefulWidget {
  _ShopipingCartState createState() => _ShopipingCartState();
}

class _ShopipingCartState extends State<ShopipingCart> {
  int cnum;
  void initState() {
    super.initState();
    cnum = 1;
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "我的购物车",
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
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    IconData(0xe630,
                                        fontFamily: Constants.ICON_FONT_FAMILY),
                                    size: 16,
                                    color: AppColors.UNDERLINE_COLOR,
                                  ),
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.network(
                                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549947658087&di=80329041dd1323c7950fb151988d9072&imgtype=0&src=http%3A%2F%2Fimg2.spzs.com%2Fgroup1%2FM00%2F26%2F0B%2FcnHoeVooFlaAAMngAADO165mJ0s619.jpg",
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  margin: EdgeInsets.only(right: 10),
                                  width: 100,
                                  height: 105,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("侗坊淳元野山茶籽油/术后康复优选/家庭食用油",
                                          style: TextStyle(
                                              color: AppColors
                                                  .ACCENTCOLOR_FONT_COLOR,
                                              fontSize: 16)),
                                      Container(
                                        child: Text("×$cnum",
                                            style: TextStyle(
                                                color: AppColors
                                                    .DEFAULT_FONT_COLOR,
                                                fontSize: 12)),
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      ),
                                      Container(
                                        child: Text("¥ 269.00",
                                            style: TextStyle(
                                                color: Color(0xffFF4A53),
                                                fontSize: 18)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      IconData(0xe63f,
                                          fontFamily: Constants.ICON_FONT_FAMILY),
                                      size: 20,
                                      color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                                    ),
                                    padding: EdgeInsets.only(left: 30),
                                  ),
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
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            IconData(0xe630,
                                fontFamily: Constants.ICON_FONT_FAMILY),
                            size: 16,
                            color: AppColors.UNDERLINE_COLOR,
                          ),
                          Container(
                            child: Text("全选",
                                style: TextStyle(
                                    color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                                    fontSize: 14)),
                            padding: EdgeInsets.only(left: 10),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () async {},
                    ),
                    width: 60,
                    height: 24,
                  ),
                  Expanded(child: Container()),
                  Container(
                    child: Text("合计：",
                        style: TextStyle(
                            color: AppColors.ACCENTCOLOR_FONT_COLOR,
                            fontSize: 16)),
                  ),
                  Container(
                    child: Text("¥ 269.00",
                        style:
                            TextStyle(color: Color(0xffFF404A), fontSize: 20)),
                    margin: EdgeInsets.only(right: 10),
                  ),
                  Container(
                    child: FlatButton(
                      child: Text("提交订单",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      onPressed: () async {},
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.THEME_MAIN_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xfff2f2f2)))),
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }
}
