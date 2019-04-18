import 'package:flutter/material.dart';

class InputGroup extends StatefulWidget {
   final Widget child;
   final String label;
   final String note;
   final String rednote;
   InputGroup({Key key, this.child,@required this.label,this.note,this.rednote}) : super(key: key);

  _InputGroupState createState() => _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.label,style: TextStyle(color: Color(0xff333333),fontSize: 18.0)),
                  Container(
                    child: widget.note!=null?Text(widget.note,style: TextStyle(color: Color(0xff333333),fontSize: 14.0)):null,
                  )
                ],
              ),
              margin: EdgeInsets.only(bottom: 10.0),
              width: double.infinity,
            ),
            Container(
              child: widget.child,
              height: 40.0,
              width: double.infinity,
              //padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xfff7f7f7),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
            ),
            Container(
              child: widget.rednote!=null?Text(widget.rednote,textAlign: TextAlign.right,style: TextStyle(color: Colors.red,fontSize: 14.0)):null,
              width: double.infinity,
              margin: EdgeInsets.only(top: 5.0),
            )
          ],
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      ),
    );
  }
}