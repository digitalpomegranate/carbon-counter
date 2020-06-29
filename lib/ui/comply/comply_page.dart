import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/colors.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/ui/comply/chart.dart';
import 'package:carbon_counter/ui/comply/compy_styles.dart';
import 'package:flutter/material.dart';

class ComplyPage extends StatefulWidget {
  @override
  _ComplyPageState createState() => _ComplyPageState();
}

class _ComplyPageState extends State<ComplyPage> {
  AppLocalizations locals;
  ThemeData theme;
  double screenWidth;

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    theme = Theme.of(context);
    // TODO this needs to change.
    List<String> data = [
      locals.transportation,
      locals.electricity,
      locals.reduce,
      locals.water,
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        locals.comply,
        style: Theme.of(context).primaryTextTheme.headline3.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
      centerTitle: true,
      leading: BackButton(color: Theme.of(context).scaffoldBackgroundColor),
    );
  }

  body() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildCards(),
          _buildResultShowingPart(),
          _buildChartPart(),
          _buildEndTextPart(),
        ],
      ),
    );
  }

  _buildResultShowingPart() {
    return Container(
      // height: 132,
      padding: EdgeInsets.symmetric(vertical: resultShowingPartPadding),
      width: screenWidth,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(resultShowingPartRadius),
        boxShadow: [
          BoxShadow(
              color: AppColors.black.withOpacity(0.15),
              blurRadius: resultShowingPartBlurRadius,
              offset: Offset(0, 0)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: containerHeight,
                  color: AppColors.sushi,
                ),
                Text(
                  locals.num1350,
                  style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                        color: AppColors.black,
                        fontSize: numFontSize,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppThemes.secondaryFontFamily,
                      ),
                ),
                Text(
                  locals.offsetPoints,
                  style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                        color: AppColors.black,
                        fontSize: offsetPointsFontSize,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppThemes.secondaryFontFamily,
                      ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppImages.compyGlobLike,
            width: compyGlobLikeWidth,
            height: compyGlobLikeHeight,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: containerHeight,
                  color: AppColors.carnation,
                ),
                Text(
                  locals.num1350,
                  style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                        color: AppColors.black,
                        fontSize: numFontSize,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppThemes.secondaryFontFamily,
                      ),
                ),
                Text(
                  locals.carbonFootprint,
                  style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                        color: AppColors.black,
                        fontSize: carbonFootprintFontSize,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppThemes.secondaryFontFamily,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //comply_glob_like.png

  _buildCards() {
    double cardSize = (screenWidth - 45) / 4;
    return Container(
      width: screenWidth,
      height: cardSize + 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: cardPaddingHorizontal,
          vertical: cardPaddingVertical,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _buildCard(
                cardSize: cardSize,
                color: AppColors.flamePea,
                textColor: AppColors.waxFlower,
                text: locals.transportation,
                imageHeight: transportationHeight,
                imageWidth: transportationWidth,
                imageAssetName: "transportation.png",
                onTap: () {}),
            SizedBox(
              width: cardSpacing,
            ),
            _buildCard(
                cardSize: cardSize,
                color: AppColors.butterCup,
                textColor: AppColors.barleyWhite,
                text: locals.electricity,
                imageHeight: electricityHeight,
                imageWidth: electricityWidth,
                imageAssetName: "electricity.png",
                onTap: () {}),
            SizedBox(
              width: cardSpacing,
            ),
            _buildCard(
                cardSize: cardSize,
                color: AppColors.sushi,
                textColor: AppColors.tidal,
                text: locals.reduce,
                imageHeight: reduceHeight,
                imageWidth: reduceWidth,
                imageAssetName: "reduce.png",
                onTap: () {}),
            SizedBox(
              width: cardSpacing,
            ),
            _buildCard(
                cardSize: cardSize,
                color: AppColors.curiousBlue,
                textColor: AppColors.anakiwa,
                text: locals.water,
                imageHeight: waterHeight,
                imageWidth: waterWidth,
                imageAssetName: "water.png",
                onTap: () {}),
          ],
        ),
      ),
    );
  }

  _buildCard(
      {Color color,
      Function onTap,
      String imageAssetName,
      double imageWidth,
      double imageHeight,
      String text,
      Color textColor,
      double cardSize}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardSize,
        height: cardSize,
        padding: EdgeInsets.only(
          left: cardPaddingLeft,
          right: cardPaddingRight,
          bottom: cardPaddingBottom,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(cardBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/icons/$imageAssetName',
                  width: imageWidth,
                  height: imageHeight,
                  color: textColor,
                ),
              ),
            ),
            Text(
              text,
              style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                    color: textColor,
                    fontSize: textFontSize,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppThemes.secondaryFontFamily,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  _buildChartPart() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: chartPartPaddingHorizontal,
        vertical: chartPartPaddingVertical,
      ),
      child: ComplyChart(),
    );
  }

  _buildEndTextPart() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: endTextPartPaddingHorizontal,
      ),
      child: Text(
        locals.dailyActivitiesOptions,
        style: Theme.of(context).primaryTextTheme.headline6.copyWith(
              color: AppColors.black,
              fontSize: dailyActivitiesOptionsFontSize,
              fontWeight: FontWeight.w400,
              fontFamily: AppThemes.secondaryFontFamily,
            ),
      ),
    );
  }
}
