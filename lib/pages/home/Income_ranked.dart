import 'package:flutter/material.dart';
import '../../components/pageBox.dart';

import '../../data/constants.dart' show AppColors;

class IncomeRanked extends StatefulWidget {
  _IncomeRankedState createState() => _IncomeRankedState();
}

class _IncomeRankedState extends State<IncomeRanked> {
  List list = List.generate(30, (i) => _UserItem());
  @override
  Widget build(BuildContext context) {
    return PageBox(
        title: "收益排行",
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text("我的当前排名：12",
                    style: TextStyle(
                        color: AppColors.ACCENTCOLOR_FONT_COLOR, fontSize: 18)),
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text("侗坊粉丝",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                              width: 124,
                            ),
                            Expanded(
                              child: Text("购买数量",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                            ),
                            Expanded(
                              child: Text("获得收益",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                            ),
                            Expanded(
                              child: Text("收益排名",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return list[index];
                          },
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                ),
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        ));
  }
}

class _UserItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/88.jpg"),
                  radius: 14,
                ),
                Container(
                  child: Text(
                    "啊吴大维达瓦的1212",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.DEFAULT_FONT_COLOR, fontSize: 14),
                  ),
                  width: 100,
                  padding: EdgeInsets.only(left: 5),
                )
              ],
            ),
          ),
          Expanded(
            child: Text("288",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.DEFAULT_FONT_COLOR, fontSize: 14)),
          ),
          Expanded(
            child: Text("¥622",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.DEFAULT_FONT_COLOR, fontSize: 14)),
          ),
          Expanded(
            child: Text("1",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.DEFAULT_FONT_COLOR, fontSize: 14)),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: 10),
    );
  }
}
