import 'package:carbon_counter/base/themes.dart';
import 'package:carbon_counter/ui/home/home_page_styles.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  final Color color;
  final String image;
  final String title;
  final Function onTap;

  MenuItem({
    this.color,
    this.image,
    this.title,
    this.onTap,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    double boxSide = MediaQuery.of(context).size.width * 0.36;
    double imageSide = MediaQuery.of(context).size.width * 0.15;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: boxSide,
        height: boxSide,
        padding: EdgeInsets.all(menuItemPadding),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(menuItemRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              widget.image,
              width: imageSide,
              height: imageSide,
              color: Theme.of(context)
                  .scaffoldBackgroundColor
                  .withOpacity(AppThemes.OPACITY_MIDDLE),
            ),
            Text(
              widget.title,
              style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(AppThemes.OPACITY_MIDDLE),
                    fontFamily: AppThemes.secondaryFontFamily,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
