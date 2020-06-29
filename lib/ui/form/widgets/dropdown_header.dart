import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/models/category.dart';
import 'package:flutter/material.dart';

class DropdownHeader extends StatelessWidget {
  final Category category;
  final bool isExpanded;
  final Duration animationDuration;
  final double maxHeight;
  final String selectedType;

  DropdownHeader({
    @required this.category,
    @required this.isExpanded,
    this.animationDuration,
    this.maxHeight,
    this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.bounceInOut,
      decoration: boxDecoration(context),
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          enumToString(selectedType ?? category?.type ?? ''),
          style: Theme.of(context)
              .primaryTextTheme
              .headline4
              .copyWith(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(BuildContext context) {
    Radius circleRadius = Radius.circular(30);
    Radius noRadius = Radius.circular(0);
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: circleRadius,
        topRight: circleRadius,
        bottomLeft: isExpanded ? noRadius : circleRadius,
        bottomRight: isExpanded ? noRadius : circleRadius,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context)
              .accentColor
              .withOpacity(AppThemes.OPACITY_MIDDLE),
          blurRadius: 7,
        ),
      ],
    );
  }
}
