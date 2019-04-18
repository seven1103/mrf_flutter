import 'package:flutter/material.dart';
import '../data/constants.dart' show Constants, AppColors;

class MoreBtn extends StatelessWidget {
  MoreBtn({Key key, @required this.text, @required this.size, @required this.onPressed})
      : assert(text != null),
        assert(size != null),
        assert(onPressed != null),
        super(key: key);
  final String text;
  final double size;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        child: Row(
          children: <Widget>[
            Text(text,
                style: TextStyle(
                    fontSize: size, color: AppColors.DEFAULT_FONT_COLOR)),
            Icon(
              IconData(0xe613, fontFamily: Constants.ICON_FONT_FAMILY),
              size: size - 2,
              color: AppColors.SECONDARYCOLOR_FONT_COLOR,
            )
          ],
        ),
        minWidth: 20,
        height: 20,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
      ),
      height: 20,
    );
  }
}
