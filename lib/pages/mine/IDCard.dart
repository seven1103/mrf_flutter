import 'package:flutter/material.dart';

import '../../components/pageBox.dart';

import '../../data/constants.dart' show Constants, AppColors;

class IDCard extends StatefulWidget {
  final Widget child;

  IDCard({Key key, this.child}) : super(key: key);

  _IDCardState createState() => _IDCardState();
}

class _IDCardState extends State<IDCard> {
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "提现卡号",
      body: Center(
        child: Container(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(IconData(0xe62f,fontFamily: Constants.ICON_FONT_FAMILY),size: 50,color: Color(0xff999797),),
              Text("版本升级中",style: TextStyle(color: Color(0xff999797),fontSize: 20),)
            ],
          ),
          margin: EdgeInsets.only(top:200.0),
        ),
      ),
    );
  }
}