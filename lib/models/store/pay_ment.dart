import 'package:flutter/material.dart';
import '../../data/constants.dart';

class PayMent {
  const PayMent({
    @required this.icon,
    @required this.title,
    @required this.color,
    @required this.value,
  });
  final int icon;
  final String title;
  final Color color;
  final String value;
}

const payMentList = [
  const PayMent(
      icon: 0xe645, title: "微信", color: Color(0xff00CD1C), value: '0'),
  const PayMent(
      icon: 0xe648, title: "支付宝", color: Color(0xff0CAFF0), value: '1'),
  const PayMent(
      icon: 0xe650, title: "钱包", color: Color(0xffFFB810), value: '2'),
];

class PayMentItem extends StatefulWidget {
  final PayMent item;
  final String payMentVal;
  final VoidCallback selectPayMent;
  final String itemType;

  PayMentItem(
      {Key key,
      @required this.item,
      @required this.payMentVal,
      @required this.selectPayMent,
      @required this.itemType})
      : super(key: key);

  _PayMentItemState createState() => _PayMentItemState();
}

class _PayMentItemState extends State<PayMentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                  IconData(widget.item.icon,
                      fontFamily: Constants.ICON_FONT_FAMILY),
                  size: widget.itemType == 'confirm_order' ? 26 : 38,
                  color: widget.item.color),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
            Expanded(
              child: Text(
                  widget.itemType == 'confirm_order'
                      ? widget.item.title + "支付"
                      : "提现到" + widget.item.title,
                  style: TextStyle(
                      color: AppColors.DEFAULT_FONT_COLOR,
                      fontSize: widget.itemType == 'confirm_order' ? 14 : 16)),
            ),
            Container(
              child: Icon(
                  IconData(
                      widget.item.value == widget.payMentVal ? 0xe637 : 0xe630,
                      fontFamily: Constants.ICON_FONT_FAMILY),
                  size: 16,
                  color: widget.item.value == widget.payMentVal
                      ? AppColors.THEME_MAIN_COLOR
                      : AppColors.UNDERLINE_COLOR),
            )
          ],
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                    widget.item.value == '0' && widget.itemType == 'withdraw'
                        ? 10
                        : 0))),
        padding: EdgeInsets.all(10),
        onPressed: widget.selectPayMent,
      ),
      height: widget.itemType == 'confirm_order' ? 50 : 65,
      margin: EdgeInsets.only(
          bottom: widget.item.value == '1' && widget.itemType == 'withdraw'
              ? 10
              : 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: widget.item.value == '0' ||
                          widget.itemType == 'confirm_order'
                      ? 1
                      : 0,
                  color: AppColors.UNDERLINE_COLOR))),
    );
  }
}
