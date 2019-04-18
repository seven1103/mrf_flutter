import 'package:flutter/material.dart';

import '../../components/pageBox.dart';

import '../../data/constants.dart' show AppColors, Constants;

class Collection extends StatefulWidget {
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "我的收藏",
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
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              child: Image.network(
                                  "http://hpimg.pianke.com/8f8f01651ecd87ec019ddd55d6855c1d20170309.png?imageView2/2/w/300/format/jpg",
                                  width: 100),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text("茶油的妙用",
                                        style: TextStyle(
                                            color: AppColors
                                                .ACCENTCOLOR_FONT_COLOR,
                                            fontSize: 16),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Container(
                                    child: Text(
                                        "茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用茶油的妙用",
                                        style: TextStyle(
                                            color: AppColors.DEFAULT_FONT_COLOR,
                                            fontSize: 14),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis),
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  ),
                                  Container(
                                    child: Text("3154浏览",
                                        style: TextStyle(
                                            color: AppColors
                                                .SECONDARYCOLOR_FONT_COLOR,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(left: 10),
                            ))
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      onPressed: () async {},
                    ),
                  ),
                  Container(
                    child: OutlineButton(
                      child: Text("取消收藏",
                          style: TextStyle(
                            color: AppColors.THEME_COLOR,
                            fontSize: 12,
                          )),
                      borderSide:
                          BorderSide(width: 0.5, color: AppColors.THEME_COLOR),
                      highlightedBorderColor: AppColors.THEME_COLOR,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      padding: EdgeInsets.all(0),
                      onPressed: () async {},
                    ),
                    height: 30,
                    width: 60,
                    margin: EdgeInsets.only(right: 10),
                  )
                ],
              ),
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              ClipRRect(
                                child: Image.network(
                                    "https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=2198363150,4231040716&fm=202"),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              Icon(
                                IconData(0xe612,
                                    fontFamily: Constants.ICON_FONT_FAMILY),
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("宝妈厨房-为更好而生活",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text("13487播放",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ))
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.THEME_COLOR,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10))),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      padding: EdgeInsets.all(10),
                      onPressed: () async {},
                    ),
                  ),
                  Container(
                    child: OutlineButton(
                      child: Text("取消收藏",
                          style: TextStyle(
                            color: AppColors.THEME_COLOR,
                            fontSize: 12,
                          )),
                      borderSide:
                          BorderSide(width: 0.5, color: AppColors.THEME_COLOR),
                      highlightedBorderColor: AppColors.THEME_COLOR,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      padding: EdgeInsets.all(0),
                      onPressed: () async {},
                    ),
                    height: 30,
                    width: 60,
                    margin: EdgeInsets.only(right: 10),
                  )
                ],
              ),
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      ),
    );
  }
}
