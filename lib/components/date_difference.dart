import 'package:flutter/material.dart';
import 'dart:async';

class DateDifference extends StatefulWidget {
  final DateTime enddate;
  final bool iscolor;
  DateDifference({Key key, this.enddate,this.iscolor=false}) : super(key: key);
  _DateDifferenceState createState() => _DateDifferenceState();
}

class _DateDifferenceState extends State<DateDifference> {
  String _timeStr;
  var _timer;
  DateTime _createTime;
  void initState() {
    super.initState();
    _timeStr = "";
    //_createTime = DateTime(2019, 5, 2, 15, 50, 00);
    _createTime = widget.enddate;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (time) {
      var now = DateTime.now();
      var diff = widget.enddate.difference(now);
      int day = (diff.inSeconds / (24 * 3600)).floor();
      int leave1 = diff.inSeconds % (24 * 3600);
      int hours = (leave1 / 3600).floor();
      int leave2 = leave1 % 3600;
      int minutes = (leave2 / 60).floor();
      int leave3 = leave2 % 60;
      int seconds = leave3.round();
      setState(() {
        _timeStr = day.toString() +
            "天" +
            hours.toString() +
            "小时" +
            minutes.toString() +
            "分钟" +
            seconds.toString() +
            "秒";
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text( _timeStr,style: TextStyle(fontSize: 16.0,color: widget.iscolor?Color(0xffB0CD5E):Colors.white));
  }
}
