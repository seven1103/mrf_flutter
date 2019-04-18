import 'package:flutter/material.dart';

class UserModel {
  String id;
  String account;
  String nickname;
  String parentAccount;
  String password;
  String payPassword;
  String icon;
  String gradeid;
  String gradeName;
  String createDate;
  String vipEndTime;
  String healthLineId;
  String state;
  String token;
  UserModel({
    @required this.id,
    @required this.account,
    this.nickname = "未设置",
    this.parentAccount = "",
    this.password = "",
    this.payPassword = "",
    this.icon,
    this.gradeid,
    this.gradeName,
    this.createDate,
    this.vipEndTime,
    this.healthLineId,
    this.state,
    this.token
  });
}