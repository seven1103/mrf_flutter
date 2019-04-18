import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './service/config.dart';
import 'dart:io';
import 'package:package_info/package_info.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
  //return new Image.asset("assets/images/qidongye.png");
  return Scaffold(
    body: Container(
      child: new Image.asset("assets/images/qidongye.png"),
    ),
    resizeToAvoidBottomPadding: false,
  );
}

  @override
  void initState() {
    super.initState();
    //判断当前是否需要更新
    countDown();
  }

// 倒计时
  void countDown() {
    //print("计时跳转");
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, appupdate);
  }

  void go2HomePage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }
// 检查版本更新
  Future appupdate() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //检查本地版本号和线上版本号是否一致
    // if(true){
    //   updateshowDialog(Text("版本更新"),'http://www.baidu.com');
    // }
    String osType;
    if(Platform.isAndroid){
      osType = '0';
    }else if(Platform.isIOS){
      osType = '1';
    }else{
      print('当前平台版本还没有开发');
      osType = null;
    }
    if(osType!=null){
      var response = await HttpUtils.request('/appInfo/getByOsType',
        method: HttpUtils.POST,
        data: {
         'osType':osType
      });
      if(response['errcode']==200){
        if(response['result']['version']==packageInfo.version){
          //print('版本一致');
          go2HomePage();
        }else{
          updateshowDialog(Text('版本更新'),response['result']['downloadUrl']);
        }
      }else{
        go2HomePage();
      }
    }
  }

  //更新弹框提示
  updateshowDialog(Widget child,String url){
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
        return new AlertDialog(
          title: child,
          actions: <Widget>[
          new FlatButton(
            child: new Text('取消'),
            onPressed: (){
            Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('确定'),
            onPressed: (){
                 webupdate(url);
            },
          )
          ],
        );
        }
      );
  }
  //网页跳转
  Future webupdate(String weburl) async{
    if (await canLaunch(weburl)) {
      await launch(weburl);
    } else {
      throw 'Could not launch $weburl';
    }
  }

  // 获取安装地址
//   Future<String> get _apkLocalPath async {
//     final directory = await getExternalStorageDirectory();
//     return directory.path;
//   }
// // //下载安装包
//   Future executeDownload() async{
//     print('开始下载');
//       final path = await _apkLocalPath;
//       print(path);
//       //下载
//       final taskId = await FlutterDownloader.enqueue(
//           //url: downLoadUrl + '/app-release.apk',
//           url:'http://oss.jqkj188.com/app.apk',
//           savedDir: path,
//           showNotification: true,
//           openFileFromNotification: true);
//           print(taskId);
//       FlutterDownloader.registerCallback((id, status, progress) {
//         print(progress);
//         print("++++++++++++++++++++++");
//         // 当下载完成时，调用安装
//         if (taskId == id && status == DownloadTaskStatus.complete) {
//           _installApk();
//         }
//       });
//   }
// //   //安装
//   Future<Null> _installApk() async {
//     // XXXXX为项目名
//     const platform = const MethodChannel("com.test/test");
//     try {
//       final path = await _apkLocalPath;
//       // 调用app地址
//       await platform.invokeMethod('install', {'path': path + '/app-release.apk'});
//     } on PlatformException catch (_) {}
//   }
}
