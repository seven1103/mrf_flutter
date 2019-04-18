import 'package:flutter/material.dart';
import '../data/constants.dart' show Constants, AppColors;

class TextAndPlaceholder extends StatefulWidget {
  final String placeholder;
  final bool isnum;
  final bool ispsw;
  final callback;

  TextAndPlaceholder({Key key,this.callback,this.placeholder,this.isnum=false,this.ispsw=false}) : super(key: key);

  _TextAndPlaceholderState createState() => _TextAndPlaceholderState();
}

class _TextAndPlaceholderState extends State<TextAndPlaceholder> {
  TextEditingController textController = TextEditingController();
  
  bool isplaceholder = true;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: TextField(
          style: TextStyle(fontSize: 16,color: AppColors.DEFAULT_FONT_COLOR),
          maxLines: 1,
          obscureText: widget.ispsw,
          keyboardType: widget.isnum?TextInputType.number:TextInputType.text,
          controller: textController,
          decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(color: AppColors.SECONDARYCOLOR_FONT_COLOR,fontSize: 16),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.2, style: BorderStyle.none)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(style: BorderStyle.none))),
          onChanged:(String a){
            widget.callback(a);
          },
        ),
        padding: EdgeInsets.only(left: 10.0),
      //  child: Stack(
      //    children: <Widget>[
      //      //isplaceholder?Text("    "+widget.placeholder,style: TextStyle(color: Color(0xffB3B1B1),height: 1.5,fontSize: 16.0)):Text(""),
      //     //  TextField(
      //     //        keyboardType: TextInputType.number,
      //     //        controller: textController,
      //     //        //autofocus: false,
      //     //        decoration: InputDecoration(
      //     //          enabledBorder: UnderlineInputBorder(
      //     //             borderSide: BorderSide(
      //     //                 width: 0.2, style: BorderStyle.none)),
      //     //         focusedBorder: UnderlineInputBorder(
      //     //             borderSide:
      //     //                 BorderSide(style: BorderStyle.none))
      //     //        ),
      //     //        textAlign: TextAlign.right,
      //     //        onChanged: (String a){
      //     //          widget.callback(a);
      //     //        },
      //     //        onTap: (){
      //     //          setState(() {
      //     //           isplaceholder = false; 
      //     //          });
      //     //        },
      //     //        //obscureText:true,
      //     //      )
          
      //    ],
      //  ),
    );
  }
}