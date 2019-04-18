import 'package:flutter/material.dart';

import 'data/constants.dart' show Constants, AppColors;
import 'pages/stores/store_screen.dart';
import 'pages/home/home_screen.dart';
import 'pages/baodan/baodan_screen.dart';
import 'models/userModel.dart';

class NavigationIconView {
  final BottomNavigationBarItem item;
  NavigationIconView({Key key, String title, Icon icon, Icon activeIcon})
      : item = BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(title),
            backgroundColor: Colors.white);
}

class HomeController extends StatefulWidget {
  final UserModel user;
  HomeController({Key key, this.user}):super(key:key);
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _currentIndex = 0;
  List<NavigationIconView> _navgationViews;
  PageController _pageController;
  List<Widget> _pages;

  void initState() {
    super.initState();
    _navgationViews = [
      NavigationIconView(
        title: '工作台',
        icon: Icon(
          IconData(
            0xe638,
            fontFamily: Constants.ICON_FONT_FAMILY,
          ),
          color: Color(0xffB3B1B1),
        ),
        activeIcon: Icon(
          IconData(0xe638, fontFamily: Constants.ICON_FONT_FAMILY),
          color: AppColors.THEME_COLOR,
        ),
      ),
      NavigationIconView(
        title: '报单',
        icon: Icon(
          IconData(
            0xe633,
            fontFamily: Constants.ICON_FONT_FAMILY,
          ),
          color: Color(0xffB3B1B1),
        ),
        activeIcon: Icon(
          IconData(0xe633, fontFamily: Constants.ICON_FONT_FAMILY),
          color: AppColors.THEME_COLOR,
        ),
      ),
      NavigationIconView(
        title: '商城',
        icon: Icon(
          IconData(
            0xe642,
            fontFamily: Constants.ICON_FONT_FAMILY,
          ),
          color: Color(0xffB3B1B1),
        ),
        activeIcon: Icon(
          IconData(0xe642, fontFamily: Constants.ICON_FONT_FAMILY),
          color: AppColors.THEME_COLOR,
        ),
      ),
    ];
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      HomeScreen(user: widget.user),
      BaodanScreen(user: widget.user),
      StoreScreen(user: widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navgationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: AppColors.THEME_COLOR,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
        });
      },
    );
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
