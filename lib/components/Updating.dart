import 'package:flutter/material.dart';

import '../data/constants.dart';

class Updating extends StatelessWidget {
  final Widget child;

  Updating({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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