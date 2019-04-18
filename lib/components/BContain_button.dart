import 'package:flutter/material.dart';

import '../data/constants.dart';

class BContainButton extends StatefulWidget {
  final Widget child;
  final String bname;
  final Function callback;
  BContainButton({Key key, this.child,@required this.bname,@required this.callback}) : super(key: key);

  _BContainButtonState createState() => _BContainButtonState();
}

class _BContainButtonState extends State<BContainButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  child: Container(
                    child: FlatButton(
                      child: Text(widget.bname,style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top: Radius.circular(10))),
                      onPressed: (){
                        widget.callback();
                      },
                      color: AppColors.THEME_MAIN_COLOR,
                    ),
                    height: 40.0,
                    width: double.infinity,
                  ),
                )
              ],
            )
          );
  }
}