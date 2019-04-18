import 'package:flutter/material.dart';
import '../data/constants.dart' show Constants, AppColors;

class PageBox extends StatelessWidget {
  PageBox(
      {Key key,
      this.hastitle = true,
      this.isDefaultAppBar = true,
      this.title = '',
      this.haveBack = true,
      this.actions,
      @required this.body})
      : assert(title != null),
        assert(body != null),
        super(key: key);
  final bool hastitle;
  final bool isDefaultAppBar;
  final String title;
  final List<Widget> actions;
  final bool haveBack;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    String bgPath = title == "侗坊粉丝部落"
        ? "assets/images/home_bg.png"
        : "assets/images/bg.png";
    return Scaffold(
      appBar: hastitle?
      AppBar(
        leading: haveBack
            ? Container(
                child: IconButton(
                  icon: Icon(
                    IconData(
                      0xe636,
                      fontFamily: Constants.ICON_FONT_FAMILY,
                    ),
                    color: isDefaultAppBar
                        ? Colors.white
                        : AppColors.ACCENTCOLOR_FONT_COLOR,
                    size: 18,
                  ),
                  highlightColor: Color.fromARGB(0, 0, 0, 0),
                  splashColor: Color.fromARGB(0, 0, 0, 0),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                width: 20,
              )
            : Container(),
        title: Text(title,
            style: TextStyle(
                color: isDefaultAppBar
                    ? Colors.white
                    : AppColors.ACCENTCOLOR_FONT_COLOR)),
        actions: actions != null ? actions : [],
        backgroundColor: isDefaultAppBar ? AppColors.THEME_MAIN_COLOR : Colors.white,
        automaticallyImplyLeading: haveBack,
        centerTitle: true,
        elevation: 0,
      )
      : null,
      body: isDefaultAppBar
          ? Container(
              child: body,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  // image: DecorationImage(
                  //     image: AssetImage(bgPath),
                  //     fit: BoxFit.fitWidth,
                  //     alignment: Alignment.topCenter)
              ),
            )
          : Container(
              child: body,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_bg.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter)),
            ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
