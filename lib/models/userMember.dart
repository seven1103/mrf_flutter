import 'package:flutter/material.dart';

class UserMemberModel {
  String healthLineType;
  String healthLineName;
  String enableFlag;
  String account;
  String nicName;
  String icon;
  String gradeName;
  String state;
  UserMemberModel(
    this.healthLineName,
    this.healthLineType,
    this.enableFlag,
    this.account,
    this.nicName,
    this.icon,
    this.gradeName,
    this.state
  );
}