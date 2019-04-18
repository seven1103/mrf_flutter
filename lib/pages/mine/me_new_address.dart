import 'package:flutter/material.dart';
import '../../components/pageBox.dart';
import '../../components/my_toast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import '../../models/me_address/addressItem.dart';
import '../../service/config.dart';
import '../../components/BContain_button.dart';

import '../../data/constants.dart' show AppColors, Constants;

//  新增地址页面
class NewAddress extends StatefulWidget {
  //  页面类型 1：新增   2：修改
  final int type;
  //  修改数据
  final AddressItem addrItem;
  //  是否是默认地址
  final bool isDefalutAddr;
  NewAddress({Key key, @required this.type, this.addrItem,@required this.isDefalutAddr})
      : assert(type != null),
        assert(isDefalutAddr != null),
        super(key: key);
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  // 收件人 输入框控制器
  TextEditingController _consigneeCon = TextEditingController();
  // 手机号 输入框控制器
  TextEditingController _phoneNumCon = TextEditingController();
  // 详细地址 输入框控制器
  TextEditingController _detailsAddrCon = TextEditingController();
  //  省
  String _province = '';
  //  市
  String _city = '';
  //  区县
  String _county = '';
  // 所在地区
  String _district;
  @override
  void initState() {
    super.initState();
    if (widget.type == 2) {
      _consigneeCon.text = widget.addrItem.name;
      _phoneNumCon.text = widget.addrItem.phone;
      _detailsAddrCon.text = widget.addrItem.detailAddress;
      _district = widget.addrItem.region;
      _province = _district.split(" ")[0];
      _city = _district.split(" ")[1];
      _county = _district.split(" ")[2];
    }
  }

  _verifyForm() {
    RegExp phoneExp = RegExp(
        '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
    if (_consigneeCon.text.isEmpty) {
      MyToast.showShortToast("请输入收货人");
      return false;
    } else if (_phoneNumCon.text.isEmpty) {
      MyToast.showShortToast("请输入手机号");
      return false;
    } else if (_district == null) {
      MyToast.showShortToast("请选择所在地区");
      return false;
    } else if (_detailsAddrCon.text.isEmpty) {
      MyToast.showShortToast("请输入详细地址");
      return false;
    } else if (!phoneExp.hasMatch(_phoneNumCon.text.toString())) {
      MyToast.showShortToast("请输入正确的手机号");
      return false;
    }
    return true;
  }

  _submitAddress() async {
    if (!_verifyForm()) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/fanshop/recvAddress/add',
        method: HttpUtils.POST,
        data: {
          'userId': prefs.getString("phoneNum"),
          'token': prefs.getString("token"),
          'name': _consigneeCon.text,
          'phone': _phoneNumCon.text,
          'region': _district,
          'detailAddress': _detailsAddrCon.text,
          'defaultFlag': 0,
        });
    if (response["errcode"] == 200) {
      MyToast.showShortToast("新增成功");
      var result = response["result"];
      Navigator.pop(
          context,
          AddressItem(
              id: result,
              name: _consigneeCon.text,
              phone: _phoneNumCon.text,
              region: _district,
              detailAddress: _detailsAddrCon.text));
    }
  }

  //  修改地址
  _updateAddress() async {
    if (!_verifyForm()) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/fanshop/recvAddress/update',
        method: HttpUtils.POST,
        data: {
          'userId': prefs.getString("phoneNum"),
          'token': prefs.getString("token"),
          'id': widget.addrItem.id,
          'name': _consigneeCon.text,
          'phone': _phoneNumCon.text,
          'region': _district,
          'detailAddress': _detailsAddrCon.text,
          'defaultFlag': widget.isDefalutAddr ? 1 : 0,          
        });
    if (response["errcode"] == 200) {
      MyToast.showShortToast("修改成功");
      Navigator.pop(
          context,
          AddressItem(
              id: widget.addrItem.id,
              name: _consigneeCon.text,
              phone: _phoneNumCon.text,
              region: _district,
              detailAddress: _detailsAddrCon.text));
    }
  }

  //  删除地址
  _deleteAddr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/fanshop/recvAddress/remove',
        method: HttpUtils.POST,
        data: {
          'userId': prefs.getString("phoneNum"),
          'token': prefs.getString("token"),
          'id': widget.addrItem.id,
        });
    if (response["errcode"] == 200) {
      MyToast.showShortToast("删除成功");
      Navigator.of(context).pop();
      Navigator.pop(context,"delete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: widget.type == 1 ? "新增收货地址" : "修改地址",
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Column(
                        children: <Widget>[
                          //  收货人
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text("收  货  人",
                                      style: TextStyle(
                                          color: AppColors.DEFAULT_FONT_COLOR,
                                          fontSize: 16)),
                                  width: 80,
                                ),
                                Expanded(
                                    child: TextField(
                                  controller: _consigneeCon,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.DEFAULT_FONT_COLOR),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.2,
                                              style: BorderStyle.none)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.none))),
                                ))
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: AppColors.UNDERLINE_COLOR))),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          //  手机号
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text("手机号码",
                                      style: TextStyle(
                                          color: AppColors.DEFAULT_FONT_COLOR,
                                          fontSize: 16)),
                                  width: 80,
                                ),
                                Expanded(
                                    child: TextField(
                                  controller: _phoneNumCon,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.DEFAULT_FONT_COLOR),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 0.2,
                                              style: BorderStyle.none)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.none))),
                                ))
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: AppColors.UNDERLINE_COLOR))),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          //  所在地区
                          Container(
                            child: FlatButton(
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("所在地区",
                                      style: TextStyle(
                                          color: AppColors.DEFAULT_FONT_COLOR,
                                          fontSize: 16)),
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                        _district == null ? "" : _district,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: AppColors.DEFAULT_FONT_COLOR,
                                            fontSize: 14)),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  )),
                                  Icon(
                                    IconData(0xe613,
                                        fontFamily: Constants.ICON_FONT_FAMILY),
                                    size: 12,
                                    color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                                  )
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0))),
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SyArea(
                                              initProvince: _province,
                                              initCity: _city,
                                              initCounty: _county,
                                            ))).then((result) {
                                  setState(() {
                                    if (result != null) {
                                      var data = result.toJson();
                                      _province = data["province"];
                                      _city = data["city"];
                                      _county = data["county"];
                                      _district = _province +
                                          " " +
                                          _city +
                                          " " +
                                          _county;
                                    }
                                  });
                                });
                              },
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: AppColors.UNDERLINE_COLOR))),
                            height: 50,
                          ),
                          //  详细地址
                          Container(
                            child: TextField(
                              controller: _detailsAddrCon,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.DEFAULT_FONT_COLOR),
                              maxLines: 3,
                              decoration: InputDecoration(
                                  hintText: "详细地址（如街道、门牌号、小区等）",
                                  hintStyle: TextStyle(
                                      color:
                                          AppColors.SECONDARYCOLOR_FONT_COLOR,
                                      fontSize: 12),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.2, style: BorderStyle.none)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(style: BorderStyle.none))),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  //   删除地址
                  Container(
                      child: widget.type == 2
                          ? GestureDetector(
                              child: Container(
                                  child: Text("删除地址",
                                      style: TextStyle(
                                          color: Color(0xffFF4A53),
                                          fontSize: 16)),
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new AlertDialog(
                                            title: new Text("提示"),
                                            content: new Text("确定要删除该地址吗？"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("取消"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("确定"),
                                                onPressed: () {
                                                  _deleteAddr();
                                                },
                                              )
                                            ]));
                              })
                          : Container(),
                      margin: EdgeInsets.only(top: 10)),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
          ),
          //  确认
          BContainButton(bname: widget.type == 1 ? "确认" : "修改",callback: widget.type == 1 ? _submitAddress : _updateAddress,)
          // Container(
          //   child: FlatButton(
          //     child: Text(widget.type == 1 ? "确认" : "修改",
          //         style: TextStyle(color: Colors.white, fontSize: 20)),
          //     padding: EdgeInsets.all(0),
          //     color: AppColors.THEME_COLOR,
          //     shape: RoundedRectangleBorder(
          //         borderRadius:
          //             BorderRadius.vertical(top: Radius.circular(10))),
          //     onPressed: widget.type == 1 ? _submitAddress : _updateAddress,
          //   ),
          //   height: 55,
          //   width: double.infinity,
          // )
        ],
      ),
    );
  }
}
