import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:carbon_counter/ui/auth/auth_styles.dart';
import 'package:carbon_counter/ui/dialogs/dialog_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  final String title;
  final String message;

  Dialogs(this.title, this.message);

  Future show() {
    return showGeneralDialog(
      context: GlobalContext.context,
      barrierColor: Theme.of(GlobalContext.context)
          .accentColor
          .withOpacity(AppThemes.OPACITY_LOW),
      transitionDuration: Duration(milliseconds: showingDuration),
      barrierLabel: GlobalContext.context.toString(),
      barrierDismissible: true,
      pageBuilder: (BuildContext context, animation, secondartAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: CupertinoAlertDialog(
              title: Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              content: Text(
                message,
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(
                    AppLocalizations().ok,
                    style: Theme.of(context).primaryTextTheme.button.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: buttonFontSize),
                  ),
                  pressedOpacity: AppThemes.OPACITY_MIDDLE,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showLoading() async {
    showGeneralDialog(
      context: GlobalContext.context,
      barrierColor:
          Theme.of(GlobalContext.context).accentColor.withOpacity(0.1),
      transitionDuration: Duration(milliseconds: loadingDuration),
      barrierDismissible: false,
      pageBuilder: (BuildContext context, animation, secondartAnimation) {
        return Container(
            color: Theme.of(context).accentColor.withOpacity(0.8),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                        backgroundColor: Colors.transparent),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.topCenter,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            AppLocalizations().loading,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline4
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: AppThemes.FONTWEIGHT_BOLD),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showCommingSoonDialog() {
    const double alertDialogPadding = 10.0;
    showDialog(
      context: GlobalContext.context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.fromLTRB(
            alertDialogPadding,
            alertDialogPadding,
            alertDialogPadding,
            alertDialogPadding * 3,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppThemes.defaultTheme.primaryColor,
                  ),
                ),
              ),
              Text(
                AppLocalizations().comingSoon,
                style: Theme.of(context).primaryTextTheme.headline5.copyWith(
                      fontFamily: AppThemes.primaryFontFamily,
                      color: AppThemes.defaultTheme.primaryColor,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future challangeDialog() async {
    showGeneralDialog(
      context: GlobalContext.context,
      barrierColor:
          Theme.of(GlobalContext.context).accentColor.withOpacity(0.1),
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: false,
      pageBuilder: (BuildContext context, animation, secondartAnimation) {
        AppLocalizations locals = AppLocalizations.of(context);
        ThemeData themeData = Theme.of(context);
        return Material(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.challengeDialogBg))),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: themeData.scaffoldBackgroundColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Text(locals.challenge,
                              style:
                                  themeData.primaryTextTheme.headline2.copyWith(
                                color: themeData.scaffoldBackgroundColor,
                              )),
                          SizedBox(height: 40),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(locals.challangeSbt,
                                textAlign: TextAlign.center,
                                style: themeData.primaryTextTheme.headline4
                                    .copyWith(
                                  color: themeData.scaffoldBackgroundColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Expanded(
                        child: Align(
                      child: Container(
                        height: buttonHeight,
                        width: buttonWidth,
                        margin: EdgeInsets.only(top: buttonMarginTop),
                        decoration: BoxDecoration(
                          color: themeData.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(buttonBorderRadius),
                          ),
                        ),
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              locals.acceptChallenge,
                              style:
                                  themeData.primaryTextTheme.headline6.copyWith(
                                color: themeData.primaryColor,
                                fontWeight: AppThemes.FONTWEIGHT_BOLD,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ))
                  ],
                ),
              )),
        );
      },
    );
  }
}
