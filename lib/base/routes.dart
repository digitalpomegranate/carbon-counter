import 'package:carbon_counter/ui/auth/auth.dart';
import 'package:carbon_counter/ui/challenges/challenges.dart';
import 'package:carbon_counter/ui/comply/comply_page.dart';
import 'package:carbon_counter/ui/form/form_page.dart';
import 'package:carbon_counter/ui/home/home_page.dart';
import 'package:carbon_counter/ui/offset/offset.dart';
import 'package:carbon_counter/ui/plans/plan_page.dart';
import 'package:carbon_counter/ui/plans/plans_summary.dart';
import 'package:carbon_counter/ui/play/play.dart';
import 'package:flutter/material.dart';

import '../ui/auth/auth.dart';

/// Provides the routes for app navigation.
/// Routes should be declared as static final members.
class AppRoutes {
  // Named routes.
  static final auth = '/';
  static final home = '/home';
  static final register = '/register';
  static final play = '/play';
  static final challenges = '/challenges';
  static final offset = '/offset';
  static final comply = '/comply';
  static final measure = '/measure';
  static final plansSummary = '/plansSummary';
  static final plan = '/plan';

  static Map<String, Widget Function(BuildContext)> namedRoutes = {
    home: (BuildContext context) => HomePage(),
    auth: (BuildContext context) => AuthPage(),
    play : (BuildContext context) => PlayPage(),
    challenges: (BuildContext context) => ChallengesPage(),
    offset: (BuildContext context) => OffsetPage(),
    comply: (BuildContext context) => ComplyPage(),
    measure : (BuildContext context) => FormPage(),
    plansSummary: (BuildContext context) => PlansSummaryPage(),
    plan:(BuildContext context) => PlanPage(),

  };


  // Callback called when user navigate to unknown route.
  static MaterialPageRoute unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }
}
