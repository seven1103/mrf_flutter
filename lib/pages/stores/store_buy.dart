import 'package:flutter/material.dart';
import '../../components/pageBox.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../models/store/pay_ment.dart';
import 'pay_keyboard.dart';
import '../mine/Address.dart';

//  确认订单页面
class ConfirmOrder extends StatefulWidget {
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  String payMent;
  void initState() { 
    super.initState();
    payMent = payMentList[0].value;
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "确认订单",
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  _ShippingAddress(),
                  _CommodityDetails(),
                  _PayMent(payMent: payMent,selectPayMent: (val){
                    setState(() {
                      payMent = val;
                    });
                  })
                ],
                //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
            ),
            //  结算栏
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text("合计",
                        style: TextStyle(
                            color: AppColors.ACCENTCOLOR_FONT_COLOR,
                            fontSize: 16)),
                    padding: EdgeInsets.only(right: 15),
                  ),
                  //  价格
                  Expanded(
                    child: Text("¥ 269.00",
                        style:
                            TextStyle(color: Color(0xffFF404A), fontSize: 20)),
                  ),
                  //  提交订单
                  Container(
                    child: FlatButton(
                      child: Text("提交订单",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return PayKeyBoard(
                                handleSubmit: (val) {
                                  print('$val');
                                },
                              );
                            });
                      },
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.THEME_MAIN_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.white,border: Border(top: BorderSide(color: Color(0xfff2f2f2)))),
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }
}

//  收获地址
class _ShippingAddress extends StatefulWidget {
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<_ShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("收货地址",
                      style: TextStyle(
                          color: AppColors.DEFAULT_FONT_COLOR, fontSize: 12)),
                ),
                // 修改地址
                Container(
                  child: FlatButton(
                    child: Text("修改地址",
                        style: TextStyle(
                            color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                            fontSize: 10)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: AppColors.UNDERLINE_COLOR,
                    splashColor: AppColors.UNDERLINE_COLOR,
                    highlightColor: AppColors.UNDERLINE_COLOR,
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ShippingAddress()));
                    },
                  ),
                  width: 60,
                  height: 20,
                )
              ],
            ),
          ),
          // 姓名、电话
          Container(
            child: Row(
              children: <Widget>[
                // 姓名
                Container(
                  child: Text("张小泉",
                      style: TextStyle(
                          color: AppColors.ACCENTCOLOR_FONT_COLOR,
                          fontSize: 16)),
                  margin: EdgeInsets.only(right: 20),
                ),
                // 电话
                Expanded(
                  child: Text("187621782678",
                      style: TextStyle(
                          color: AppColors.ACCENTCOLOR_FONT_COLOR,
                          fontSize: 16)),
                )
              ],
            ),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
          //  收获地址
          Text("收货地址：贵州省贵阳市云岩区中华北路数据小区088号天毅大厦2栋21层08室",
              style:
                  TextStyle(color: AppColors.DEFAULT_FONT_COLOR, fontSize: 12))
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}

//  商品详情
class _CommodityDetails extends StatefulWidget {
  _CommodityDetailsState createState() => _CommodityDetailsState();
}

class _CommodityDetailsState extends State<_CommodityDetails> {
  int cnum;
  void initState() {
    super.initState();
    cnum = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                //  商品图片
                Container(
                  child: ClipRRect(
                    child: Image.network(
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549947658087&di=80329041dd1323c7950fb151988d9072&imgtype=0&src=http%3A%2F%2Fimg2.spzs.com%2Fgroup1%2FM00%2F26%2F0B%2FcnHoeVooFlaAAMngAADO165mJ0s619.jpg",
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  height: 105,
                ),
                //  名称、价格、规格、数量
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //  名称
                      Text("侗坊淳元野山茶籽油/术后康复优选/家庭食用油",
                          style: TextStyle(
                              color: AppColors.ACCENTCOLOR_FONT_COLOR,
                              fontSize: 16)),
                      //  规格
                      Container(
                        child: Text("500ml",
                            style: TextStyle(
                                color: AppColors.DEFAULT_FONT_COLOR,
                                fontSize: 12)),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      ),
                      //  价格、数量
                      Container(
                        child: Row(
                          children: <Widget>[
                            //  价格
                            Expanded(
                              child: Text("¥ 269.00",
                                  style: TextStyle(
                                      color: Color(0xffFF4A53), fontSize: 18)),
                            ),
                            //  数量
                            Text("×$cnum",
                                style: TextStyle(
                                    color: AppColors.DEFAULT_FONT_COLOR,
                                    fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: AppColors.UNDERLINE_COLOR))),
          ),
          //  购买数量
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("购买数量",
                      style: TextStyle(
                        color: AppColors.DEFAULT_FONT_COLOR,
                        fontSize: 14,
                      )),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          child: Text("-",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.DEFAULT_FONT_COLOR)),
                          color: AppColors.UNDERLINE_COLOR,
                          highlightColor: AppColors.UNDERLINE_COLOR,
                          splashColor: AppColors.UNDERLINE_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              cnum = cnum == 1 ? 1 : cnum - 1;
                            });
                          },
                        ),
                        width: 20,
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("$cnum",
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.DEFAULT_FONT_COLOR)),
                        width: 40,
                      ),
                      Container(
                        child: FlatButton(
                          child: Text("+",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.DEFAULT_FONT_COLOR)),
                          color: AppColors.UNDERLINE_COLOR,
                          highlightColor: AppColors.UNDERLINE_COLOR,
                          splashColor: AppColors.UNDERLINE_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              cnum++;
                            });
                          },
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: AppColors.UNDERLINE_COLOR))),
          ),
          //  配送方式
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("配送方式",
                      style: TextStyle(
                        color: AppColors.DEFAULT_FONT_COLOR,
                        fontSize: 14,
                      )),
                ),
                Text("快递 免邮",
                    style: TextStyle(
                      color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                      fontSize: 14,
                    ))
              ],
            ),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: AppColors.UNDERLINE_COLOR))),
          ),
          //  积分
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("扣除积分",
                      style: TextStyle(
                        color: AppColors.DEFAULT_FONT_COLOR,
                        fontSize: 14,
                      )),
                ),
                Text("-50积分",
                    style: TextStyle(
                      color: Color(0xffff404a),
                      fontSize: 14,
                    ))
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
//  支付详情
class _PayMent extends StatefulWidget {
  final String payMent;
  final selectPayMent;
  _PayMent({Key key,@required this.payMent,@required this.selectPayMent})
  :assert(payMent != null),
  assert(selectPayMent != null),
  super(key:key);
  _PayMentState createState() => _PayMentState();
}

class _PayMentState extends State<_PayMent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text("支付方式",
                style: TextStyle(
                    color: AppColors.DEFAULT_FONT_COLOR, fontSize: 14)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          ),
          //  支付项
          PayMentItem(
              item: payMentList[0],
              payMentVal: widget.payMent,
              itemType: "confirm_order",
              selectPayMent: () {
                widget.selectPayMent(payMentList[0].value);
              }),
          PayMentItem(
              item: payMentList[1],
              payMentVal:  widget.payMent,
              itemType: "confirm_order",
              selectPayMent: () {
                widget.selectPayMent(payMentList[1].value);
              }),
        ],
      ),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
    );
  }
}
