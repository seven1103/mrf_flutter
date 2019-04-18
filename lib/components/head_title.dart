import 'package:flutter/material.dart';

import '../pages/mine/mine_screen.dart';

import '../data/constants.dart' show Constants, AppColors;
import '../models/userModel.dart';

class HeadTitle extends StatelessWidget {
  final String title;
  final UserModel user;
  HeadTitle({Key key, @required this.title,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(""),
                ),
                Expanded(
                  flex: 10,
                  child: Text("$title",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        IconData(0xe647,fontFamily: Constants.ICON_FONT_FAMILY),
                        color: Colors.white,
                        size: 18,
                      ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MIneScreen(user: user,)
                              )
                        );
                    },
                  )
                )
              ],
            ),
        ),
    );
  }
}