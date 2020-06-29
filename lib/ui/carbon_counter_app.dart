import 'package:carbon_counter/base/base.dart';
import 'package:carbon_counter/base/keys.dart';
import 'package:carbon_counter/base/routes.dart';
import 'package:carbon_counter/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CarbonCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations().carbonCounter,
      theme: AppThemes.defaultTheme,
      initialRoute: AppRoutes.auth,
      navigatorKey: AppKeys.navigatorkey,
      routes: AppRoutes.namedRoutes,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
      ],
    );
  }
}
