import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/ui/dialogs/dialogs.dart';
import 'package:carbon_counter/ui/play/play_styles.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  AppLocalizations locals;
  ThemeData theme;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    locals = AppLocalizations.of(context);
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Map<String, String> playTypes = {
    'Challenges': AppImages.challenge,
    'Teams': AppImages.team,
    'Competitions': AppImages.competition,
    'Leaderboard': AppImages.leaderboard,
  };
  
  List<String> descriptions = [
    AppLocalizations().challengesDescription,
    AppLocalizations().teamsDescription,
    AppLocalizations().competitionsDescription,
    AppLocalizations().leaderboardsDescription,
  ];

  Widget body() {
    return Container(
      margin: EdgeInsets.only(
        top: tileMarginVertical,
        left: tileMarginHorizontal,
        right: tileMarginHorizontal,
      ),
      child: ListView.builder(
        itemCount: playTypes.values.toList().length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).pushNamed(AppRoutes.challenges);
              } else
                Dialogs.showCommingSoonDialog();
            },
            child: Container(
              height: tileHight,
              margin: EdgeInsets.only(
                top: tileMarginVertical,
                bottom: tileMarginVertical,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      playTypes.values.toList()[index],
                      width: MediaQuery.of(context).size.width,
                      height: tileHight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  itemIcon(index),
                  itemDescription(index),
                  itemTitle(index)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget itemIcon(int index) {
    return Container(
      child: Image.asset(
       playTypes.values.toList()[index],
        width: MediaQuery.of(context).size.width,
        height: tileHight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget itemTitle(int index) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(contentPadding),
        margin: EdgeInsets.only(top: contentPadding),
        width: titleWidth,
        decoration: BoxDecoration(
          color: theme.accentColor.withOpacity(
            AppThemes.OPACITY_LOW,
          ),
          borderRadius: BorderRadius.circular(titleRadius),
          border: Border.all(color: theme.scaffoldBackgroundColor, width: 1.0),
        ),
        child: Text(
          playTypes.keys.toList()[index],
          textAlign: TextAlign.center,
          style: theme.primaryTextTheme.button.copyWith(
            fontFamily: AppThemes.secondaryFontFamily,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  Widget itemDescription(int index) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: tileTitleHeight,
        width: MediaQuery.of(context).size.width,
        color: theme.accentColor.withOpacity(
          AppThemes.OPACITY_LOW,
        ),
        padding: EdgeInsets.all(contentPadding),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            descriptions[index],
            style: theme.primaryTextTheme.headline6.copyWith(
              fontFamily: AppThemes.secondaryFontFamily,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text(
        locals.play,
        style: theme.primaryTextTheme.headline3.copyWith(
          color: theme.scaffoldBackgroundColor,
        ),
      ),
      centerTitle: true,
      leading: BackButton(color: theme.scaffoldBackgroundColor),
    );
  }
}
