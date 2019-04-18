import 'package:flutter/material.dart';
import '../data/constants.dart' show Constants, AppColors;

class SelectDialog extends StatefulWidget {
  final String selectindex;
  final selectList;
  final callback;
  SelectDialog({Key key,this.selectindex,this.selectList,this.callback}) : super(key: key);

  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {

  void showSelectDialog(BuildContext context){
    showDialog<Null>(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          title: Text("请选择",style: TextStyle(fontSize: 16.0),),
          children:buildOptionList(widget.selectList)
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.selectindex),
          Icon(IconData(0xe634,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffcccccc),size: 10.0,),
        ],
      ),
      color: Color(0xfff7f7f7),
      onPressed: (){
        showSelectDialog(context);
      },
    );
  }

  List<Widget> buildOptionList(List list){
    List<Widget> widgetList = new List();
    for(int i=0;i<list.length;i++){
      widgetList.add(SimpleDialogOption(child: Text(list[i],style: TextStyle(color: Color(0xff666666))),
              onPressed: (){
                //print(list[i]);
                widget.callback(list[i]);
                Navigator.of(context).pop();
              },
      ));
    }
    return widgetList;
  }
}