import 'dart:math';

import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/colors.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/models/challenge.dart';
import 'package:carbon_counter/ui/challenges/challenge_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengeItem extends StatefulWidget {
  final Challenge challenge;

  ChallengeItem({
    @required this.challenge,
  });

  @override
  _ChallengeItemState createState() => _ChallengeItemState();
}

class _ChallengeItemState extends State<ChallengeItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: challengeHeight,
            margin: EdgeInsets.only(
                left: tileMarginHorizontal,
                right: tileMarginHorizontal,
                top: tileMarginVertical,
                bottom: tileMarginVertical),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(tileBorderradius)),
              color: AppColors.challengeColors[
                  Random().nextInt(AppColors.challengeColors.length)],
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    challengeIcon(),
                    nameAndDescription(),
                  ],
                ),
                challengeBenefitts(),
              ],
            ),
          ),
          joinButton()
        ],
      ),
    );
  }

  Widget challengeBenefitts() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: benefitMargin,
                right: benefitMargin,
                top: benefitMargin,
              ),
              child: Text(
                "${AppLocalizations().startBenefit}: ${widget.challenge.startBenefit}",
                style: Theme.of(context).primaryTextTheme.caption.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontFamily: AppThemes.secondaryFontFamily),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: benefitMargin,
                  right: benefitMargin,
                  top: benefitMargin,),
              child: Text(
                "${AppLocalizations().finishBenefit}: ${widget.challenge.finishBenefit}",
                style: Theme.of(context).primaryTextTheme.caption.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontFamily: AppThemes.secondaryFontFamily),
              ),
            ),
          ],
        ),
        Row(children: [
          Container(
            margin: EdgeInsets.only(
              left: benefitMargin,
              right: benefitMargin,
              top: benefitMargin,
            ),
            child: Text(
              "${AppLocalizations().ecoBenefit}: ${widget.challenge.ecoBenefit}",
              style: Theme.of(context).primaryTextTheme.caption.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontFamily: AppThemes.secondaryFontFamily),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: benefitMargin, right: benefitMargin, top: benefitMargin),
            child: Text(
              "${AppLocalizations().moneyBenefit}: ${widget.challenge.moneyBenefit}",
              style: Theme.of(context).primaryTextTheme.caption.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontFamily: AppThemes.secondaryFontFamily),
            ),
          ),
        ]),
      ],
    );
  }

  Widget challengeIcon() {
    return Container(
      margin: EdgeInsets.only(
        top: iconMargin,
        left: iconMargin,
        right: iconMargin,
      ),
      child: Image.network(
        widget.challenge.icon,
        height: iconHeight,
        width: iconHeight,
      ),
    );
  }

  Widget nameAndDescription() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(left: textMarginLeft, right: textMarginRight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: titleMarginTop),
            child: Text(
              widget.challenge.challengeName,
              style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: AppThemes.FONTWEIGHT_BOLD),
            ),
          ),
          RichText(
            text: TextSpan(
              text: widget.challenge.challengeDesc,
              style: Theme.of(context).primaryTextTheme.caption.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontFamily: AppThemes.secondaryFontFamily),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget joinButton() {
    return Container(
      width: joinButonWidth,
      height: joinButtonHeight,
      margin:
          EdgeInsets.only(right: buttonMarginRight, bottom: buttonMarginBottom),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(buttonBorderRadius),
        ),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          AppLocalizations().join,
          style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                color: Theme.of(context).accentColor,
                fontFamily: AppThemes.secondaryFontFamily,
              ),
        ),
        onPressed: () {},
      ),
    );
  }
}
