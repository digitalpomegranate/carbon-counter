import 'package:carbon_counter/management/challenges/challenges.dart';
import 'package:carbon_counter/management/calculations/calculations.dart';
import 'package:carbon_counter/management/categories/categories.dart';
import 'package:carbon_counter/management/plans/plans.dart';
import 'package:carbon_counter/management/users/users.dart';

/// AppModel is responsible for managing the app state and
///  communicating with Cloud/API, DB and UI layers.
/// AppModel is based on singleton pattern to have single instance
/// accross the app.
class AppModel {
  static AppModel _singleton;

  final Users users = Users();
  final Challenges challenges = Challenges(); 
  final Plans plans = Plans();
  // final Auth auth = Auth();
  final Categories categories = Categories();
  final Calculations calculations = Calculations();

  factory AppModel() {
    if (_singleton == null) {
      _singleton = AppModel._internal();
    }

    return _singleton;
  }

  // Private internal constructor.
  AppModel._internal();
}
