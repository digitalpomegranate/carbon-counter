import 'dart:convert';
import 'dart:math';

import 'package:carbon_counter/base/colors.dart';
import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/plan/plan.dart';
import 'package:carbon_counter/ui/plans/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

import '../../../base/themes.dart';

class PlanItem extends StatelessWidget {
  final Plan plan;
  final Function onPressed;
  ThemeData theme;
  PlanItem({Key key, @required this.plan, @required this.onPressed})
      : super(key: key);

  NotusDocument document;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    document = NotusDocument.fromJson(jsonDecode(plan.content));

    return Dismissible(
      background: Container(color: Colors.red),
      key: GlobalKey(),
      child: FlatButton(
        padding: EdgeInsets.symmetric(
            vertical: contentVerticalPadding,
            horizontal: contentHorizontalPadding),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: planImage(),
          title: titleContent(),
        ),
        onPressed: onPressed,
      ),
      onDismissed: (d) {
        AppModel().plans.delete(plan);
      },
    );
  }

  /// Widgets
  Widget planImage() {
    return Container(
      height: planItemSize,
      width: planItemSize,
      decoration: BoxDecoration(
        color: AppColors.challengeColors[
            Random().nextInt(AppColors.challengeColors.length)],
        borderRadius: BorderRadius.all(
          Radius.circular(planItemBorderRadius),
        ),
      ),
    );
  } //

  Widget titleContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          plan.title,
          maxLines: 1,
          style: theme.primaryTextTheme.title.copyWith(
              fontWeight: FontWeight.w400,
              fontFamily: AppThemes.secondaryFontFamily),
        ),
        Text(
          document.toPlainText(),
          maxLines: 1,
          style: theme.primaryTextTheme.title.copyWith(
              fontSize: planItemSubtitleFontSize,
              fontWeight: FontWeight.w200,
              fontFamily: AppThemes.secondaryFontFamily),
        )
      ],
    );
  }

  Widget subtitle() {
    return Text(plan.content);
  }
}
