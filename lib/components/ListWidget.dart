import 'package:flutter/material.dart';

List<Widget> buildMyList(List DataList,item) {
  List<Widget> widgetList = new List();
  for (int i = 0; i < DataList.length; i++) {
    widgetList.add(item);
  }
  return widgetList;
}

