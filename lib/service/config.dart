import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../components/Loading.dart';
import '../components/my_toast.dart';

/*
 * 封装 restful 请求
 * 
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtils {
  /// global dio object
  static Dio dio;

  /// default options
  // static const String API_PREFIX = 'http://112.74.177.12:8060';
  //static const String API_PREFIX = 'http://192.168.1.107:8060';
  static const String API_PREFIX = 'http://47.107.100.130:8060';
  //static const String API_PREFIX = 'http://192.168.1.149:8080';
  static const String IMG_BASEURL =  'http://oss.qskjjt.com/';
  static const String CONTENT_TYPE = "JSON";
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 5000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /// request method
  static Future<Map> request(String url, {data, method,sendProgress,context}) async {
    data = data ?? {};
    method = method ?? 'GET';
    sendProgress = sendProgress ?? null;
    context = context ?? null;

    /// restful 请求处理
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    // print('ip：【'+API_PREFIX + '】');
    // print('请求地址：【' + method + '  ' + url + '】');
    // print('请求参数：' + data.toString());

    Dio dio = createInstance();
    var result;
    try {
      Future futures = dio.request(url,
          data: data, options: new Options(method: method),onSendProgress: sendProgress);
      if(context!=null){
        httpLoading(context,futures);
      }
      Response response = await futures;
      if (url == "/user/login") {
        response.data["token"] = response.headers["token"];
      }
      result = response.data;

      /// 打印响应相关信息
      //print('响应数据：' + response.toString());
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
      result = {'errcode':503,'errmsg':e,result:{}};
    }
    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
          baseUrl: API_PREFIX,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          contentType: ContentType.parse("application/x-www-form-urlencoded"));

      dio = new Dio(options);
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // 在请求被发送之前做一些事情
        return options; //continue
      }, onResponse: (Response response) async {
        // 在返回响应数据之前做一些预处理
        // print(response.request.data);
        if (response.data["errcode"] == 500) {
          MyToast.showLongToast(response.data["errmsg"]);
        } else if (response.data["errcode"] == 501) {
          //print(response);
          //return await _getoken(response.request.path,response.request.data);
        } else {
          return response;
        }
      }, onError: (DioError e) {
        // 当请求失败时做一些预处理
        MyToast.showLongToast("网络错误,请稍后重试");
        return e; //continue
      }));
    }
    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  static Future _getoken(String url, Map params) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
          var getToken = await HttpUtils.request("/user/login",
              method: HttpUtils.POST, data: {
                'account': pres.getString("account"),
                'password': pres.getString("inputpassword"),
              });
    params["token"] = getToken["token"][0];
    pres.setString("token", getToken["token"][0]);
    Response response = await dio.request(url,
        data: params, options: new Options(method: POST));
    return response.data;
  }

  //请求loading动画效果
  static httpLoading(BuildContext context,Future request){
     showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return new NetLoadingDialog(
          outsideDismiss: false,
          requestCallBack: request,
        );
      });
  }

}
