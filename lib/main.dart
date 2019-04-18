import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'login.dart';
import 'register.dart';
import 'retrievePwd.dart';
import 'homeController.dart';
import 'pages/home/Income_ranked.dart';
import 'splashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    return MaterialApp(
      title: 'baodan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        platform: TargetPlatform.iOS
      ),
      home: SplashPage(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/retrievePwd': (context) => RetrievePwd(),
        '/HomeController': (context) => HomeController(),
        '/IncomeRanked': (context) => IncomeRanked(),
      },
    );
  }
}