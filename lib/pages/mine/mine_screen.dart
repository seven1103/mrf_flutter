import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../components/pageBox.dart';
import '../../data/constants.dart' show Constants, AppColors;
import '../../pages/mine/UserNick.dart';
import '../../pages/mine/LoginPW.dart';
import '../../pages/mine/PayPW.dart';
import '../../pages/mine/Address.dart';
import '../../pages/mine/Order.dart';
import '../../pages/mine/Colection.dart';
import '../../pages/mine/ShopCart.dart';
import '../../pages/mine/IDCard.dart';
import '../../models/userModel.dart';
import '../../service/config.dart';
import '../../components/Loading.dart';
import '../../components/my_toast.dart';


class MIneScreen extends StatefulWidget {
  final Widget child;
  final UserModel user;
  MIneScreen({Key key, this.child,this.user}) : super(key: key);
  
  MIneScreenState createState() => MIneScreenState();
}

class MIneScreenState extends State<MIneScreen> {
  File _picture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateUserAvater(BuildContext contexts){
    showDialog(
      context: contexts,
      barrierDismissible: false,
      builder: (BuildContext context){
        return _UpdateAvatar(handleUpdateAvatar: (File val) async{
         Navigator.pop(context);
          if(val != null){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // FormData formData = new FormData.from({
            //   'projId':'1',
            //   'isSingleFile':'1',
            //   'isUnzip':'0',
            //   "file": new UploadFileInfo(val, "icon.jpg",contentType:ContentType.parse("multipart/form-data")),
            //   "token":  prefs.getString("token")
            // });
            // var response = HttpUtils.request("/file/upload",
            //   method: HttpUtils.POST,
            //   data: formData,
            // );
            FormData formData = new FormData.from({
              "file": new UploadFileInfo(val, "icon.jpg",contentType:ContentType.parse("multipart/form-data")),
            });
            var response = HttpUtils.request("/file/uploadQiNiu",
              method: HttpUtils.POST,
              data: formData,
            );
            show(response,contexts);
            response.then((val){
              print(val);
              if(val["errcode"]==200){
                var data = val['result'];
                String fileid = data[data.length-1]['fileId'];
                setState(() {
                 widget.user.icon =  fileid;
                });
                updateicon(fileid);
              }else{
                MyToast.showLongToast("上传失败");
              }
            });
          }
           
        },);
      }
    );
  }
  void route(String title){
    Map routeMap =Map();
    routeMap = {"修改登录密码":LoginPW(account: widget.user.account,),"支付密码":PayPW(user: widget.user),"我的地址":ShippingAddress(),"我的订单":CommodityOrders(),
    "我的收藏":Collection(),"我的购物车":ShopipingCart(),"提现卡号":IDCard()};
    print(routeMap[title]);
    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>routeMap[title]));
  }
  void exit(String title){
    Navigator.of(context).pushReplacementNamed('/login');
  }
  void updateNick(BuildContext context,String name){
    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => UserNick(user: widget.user)));
  }
 
  Future updateicon(String icon) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await HttpUtils.request('/user/updateUser',
        method: HttpUtils.POST,
        data: {
          "account":widget.user.account,
          "icon": icon,
          "token" :prefs.getString("token")
    });
    if(response['errcode']){
      MyToast.showShortToast("上传成功");
    }else{
      MyToast.showShortToast("提交失败");
    }
  }
  void show(callback,BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new NetLoadingDialog(
            outsideDismiss: false,
            requestCallBack: callback,
          );
        });
  }
    //图片资源拼接
  String _httpimg(String src) {
    //print()
    return HttpUtils.IMG_BASEURL + src;
  }
  @override
  Widget build(BuildContext context) {
    return PageBox(
      title: "个人中心",
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("头像"),
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: widget.user.icon==null?AssetImage("assets/images/user.png"):NetworkImage(_httpimg(widget.user.icon)),
                        radius: 25,
                      ),
                      Container(
                        child:Icon(IconData(0xe635,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffcccccc),size: 16,),
                        margin: EdgeInsets.only(left: 5.0),
                      )
                      
                    ],
                  )
                ],
              ),
              margin: EdgeInsets.only(bottom: 10.0),
              //padding: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.white
              ),
            ),
            onTap: (){
              updateUserAvater(context);
            },
          ),
          Container(
            child: Column(
              children: <Widget>[
                _MineItem(title: "昵称",trailing: widget.user.nickname,callback: (title){
                  updateNick(context,widget.user.nickname);
                }),
                _MineItem(title: "会员账号",trailing: widget.user.account,trailingIcon: false),
                _MineItem(title: "会员等级",trailing: widget.user.gradeName,trailingIcon: false),
                _MineItem(title: "修改登录密码",callback: route),
                _MineItem(title: "支付密码",callback: route),
              ],
            ),
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            decoration: BoxDecoration(
              color: Colors.white
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                _MineItem(title: "我的地址",callback: route),
                _MineItem(title: "我的订单",callback: route),
                _MineItem(title: "我的收藏",callback: route),
                _MineItem(title: "我的购物车",callback: route),
                _MineItem(title: "提现卡号",callback: route),
                _MineItem(title: "注册时间",trailing: widget.user.createDate,trailingIcon: false,),
                _MineItem(title: "退出登录",callback: exit),
              ],
            ),
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            decoration: BoxDecoration(
              color: Colors.white
            ),
          )
        ],
      )
    );
  }
}

class _MineItem extends StatelessWidget {
  final String title;
  final String trailing;
  final bool trailingIcon;
  final bool isend;
  final callback;
  _MineItem({Key key,  
    @required this.title,
    this.trailing = "",
    this.trailingIcon = true,
    this.isend = false,
    this.callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              Row(
                children: <Widget>[
                  Text(trailing),
                  Container(
                    child: trailingIcon? Icon(IconData(0xe635,fontFamily: Constants.ICON_FONT_FAMILY),color: Color(0xffcccccc),size: 16.0,):null,
                  )
                ],
              )
            ],
          ),
          
        ),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xfff7f7f7)))
        ),
      ),
      onTap: (){
        callback(title);
        //Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) =>callback));
      },
    );
  }

  //_MineItemState createState() => _MineItemState();
}


class _UpdateAvatar extends Dialog {
  final handleUpdateAvatar;
  _UpdateAvatar({Key key, this.handleUpdateAvatar});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          child: Column(
            children: <Widget>[
              //  相册选择
              Container(
                child: FlatButton(
                  child: Text("从相册中选择",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.DEFAULT_FONT_COLOR)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                  color: Colors.white,
                  onPressed: () async {
                    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                    handleUpdateAvatar(image);
                  },
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.UNDERLINE_COLOR, width: 1))),
                height: 50,
                width: 280,
              ),
              //  拍照
              Container(
                child: FlatButton(
                  child: Text("拍照",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.DEFAULT_FONT_COLOR)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(0))),
                  color: Colors.white,
                  onPressed: () async {
                    File image = await ImagePicker.pickImage(source: ImageSource.camera);
                    handleUpdateAvatar(image);
                  },
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.UNDERLINE_COLOR, width: 1))),
                height: 50,
                width: 280,
              ),
              Container(
                child: FlatButton(
                  child: Text("取消",
                      style: TextStyle(
                          fontSize: 16, color: AppColors.DEFAULT_FONT_COLOR)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                  color: Colors.white,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                height: 50,
                width: 280,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}