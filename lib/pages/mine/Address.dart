import 'package:flutter/material.dart';
import '../../components/pageBox.dart';

import '../../data/constants.dart' show AppColors,Constants;
import '../mine/me_new_address.dart';
import '../../models/me_address/addressItem.dart';

class ShippingAddress extends StatefulWidget {
  final int type;
  ShippingAddress({Key key, this.type=0}) : super(key: key);
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {

  List<AddressItem> _addressList;
  String _defaultAddr = "123123";
  AddressItem addressItem;

  void initState() { 
    super.initState();
    _addressList = List<AddressItem>();
    _getAddressList();
  }

  _getAddressList() async{
    List dataList = [
      {"id":"123123","name":"李元鹏","phone":"18785187439","region":"贵州省贵阳市白云区","detailAddress":"麦架镇"},
      {"id":"1231we","name":"李元鹏","phone":"18785187439","region":"贵州省贵阳市云岩区","detailAddress":"理工学院"}
    ];
    setState(() {
     dataList.forEach((item){
       AddressItem addrItem = AddressItem(
              id: item["id"],
              name: item["name"],
              phone: item["phone"],
              region: item["region"],
              detailAddress: item["detailAddress"]);
          _addressList.add(addrItem);
     }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "收货地址",
      // body: Center(
      //   child: Container(
      //     child: Column(
      //       // mainAxisSize: MainAxisSize.max,
      //       // crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         Icon(IconData(0xe62f,fontFamily: Constants.ICON_FONT_FAMILY),size: 50,color: Color(0xff999797),),
      //         Text("版本升级中",style: TextStyle(color: Color(0xff999797),fontSize: 20),)
      //       ],
      //     ),
      //     margin: EdgeInsets.only(top:200.0),
      //   ),
      // ),
        body: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(IconData(0xe62e,fontFamily: Constants.ICON_FONT_FAMILY),color: AppColors.THEME_MAIN_COLOR,size: 30,),
                  Container(
                    child: Text("新增地址",style: TextStyle(fontSize: 16.0,color: Color(0xff666666))),
                    margin: EdgeInsets.only(left: 10.0),
                  )
                ],
              ),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10.0),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => NewAddress(type: 1,isDefalutAddr: false,)
              ));
            },
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _addressList.length,
                itemBuilder: (BuildContext contex,int index) => 
                _AddressItemWidget(
                  item: _addressList[index],
                  defultAddr: _defaultAddr,
                  index:index,
                type: widget.type,
                  setDefaultAddr:(){},
                  updateAddress: () {
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>
                        NewAddress(
                        type: 1,
                        addrItem: _addressList[index],
                        isDefalutAddr:false)
                      ));
                  }
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  地址项模板
class _AddressItemWidget extends StatefulWidget {
  //  数据模型
  final AddressItem item;
  //  默认地址ID
  final String defultAddr;
  //  设置默认地址方法
  final VoidCallback setDefaultAddr;
  //  修改地址方法
  final VoidCallback updateAddress;
  //  索引
  final int index;
  // 类型（0 编辑地址 1选择地址）
  final int type;
  _AddressItemWidget(
      {Key key,
      @required this.item,
      @required this.defultAddr,
      @required this.setDefaultAddr,
      @required this.updateAddress,
      @required this.index,
      @required this.type})
      : assert(item != null),
        super(key: key);

  _AddressItemWidgetState createState() => _AddressItemWidgetState();
}

class _AddressItemWidgetState extends State<_AddressItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Icon(
                IconData(
                    widget.defultAddr == widget.item.id
                        ? 0xe637
                        : 0xe630,
                    fontFamily: Constants.ICON_FONT_FAMILY),
                size: 14,
                color: widget.defultAddr == widget.item.id
                    ? AppColors.THEME_MAIN_COLOR
                    : AppColors.UNDERLINE_COLOR,
              ),
              padding: EdgeInsets.fromLTRB(5, 30.0, 10.0, 0),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    //  姓名、电话
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(widget.item.name,
                              style: TextStyle(
                                  color: AppColors.ACCENTCOLOR_FONT_COLOR,
                                  fontSize: 14)),
                          Container(
                            child: Text(widget.item.phone,
                                style: TextStyle(
                                    color: AppColors.ACCENTCOLOR_FONT_COLOR,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)),
                            margin: EdgeInsets.only(left: 10),
                          )
                        ],
                      ),
                    ),
                    //  地址
                    Container(
                      child: Text(
                          widget.item.region + " " + widget.item.detailAddress,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.SECONDARYCOLOR_FONT_COLOR,
                              fontSize: 14,
                              fontWeight: FontWeight.w300)),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      width: double.infinity,
                    ),
                    //  设为默认地址
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            
                            Text("设为默认地址",
                                style: TextStyle(
                                    color: AppColors.DEFAULT_FONT_COLOR,
                                    fontSize: 14))
                          ],
                        ),
                        padding: EdgeInsets.all(0),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: widget.setDefaultAddr,
                      ),
                      height: 20,
                    )
                  ],
                ),
                margin: EdgeInsets.only(right: 10),
              ),
            ),
            //  编辑
            Container(
              child: OutlineButton(
                child: Text("编辑",
                    style:
                        TextStyle(color: AppColors.THEME_MAIN_COLOR, fontSize: 14)),
                highlightedBorderColor: AppColors.THEME_MAIN_COLOR,
                borderSide:
                    BorderSide(width: 0.5, color: AppColors.THEME_MAIN_COLOR),
                padding: EdgeInsets.all(0),
                onPressed: widget.updateAddress,
              ),
              width: 65,
              height: 30,
            )
          ],
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: widget.index == 0
                ? null
                : Border(
                    top:
                        BorderSide(width: 1, color: AppColors.UNDERLINE_COLOR)),
            borderRadius: widget.index == 0
                ? BorderRadius.vertical(top: Radius.circular(10))
                : null),
      ),
      onTap: () {
        if (widget.type == 1) {
          Navigator.pop(context, widget.item);
        }
      },
    );
  }
}

