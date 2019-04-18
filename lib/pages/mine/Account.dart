import 'package:flutter/material.dart';

import '../../components/pageBox.dart';

import '../../data/constants.dart' show Constants, AppColors;
class Account extends StatefulWidget {

  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    
    return PageBox(
      title:"商城",
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
      )
    );
  }
}