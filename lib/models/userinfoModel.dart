import 'package:flutter/material.dart';

class UserInfoModel {
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

  String assetsXin;
  String assetsXi;
  String assetsJifen;

  String line1;
  String line2;
  String line3;
  
  UserInfoModel({
    @required this.id,
    @required this.account,
    this.nickname = "123",
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
    this.token,

    this.assetsXin = '',
    this.assetsXi = '',
    this.assetsJifen = '',

    this.line1 = '',
    this.line2 = '',
    this.line3 = ''
  });
}