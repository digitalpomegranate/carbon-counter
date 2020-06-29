import 'package:carbon_counter/api/api.dart';
import 'package:carbon_counter/models/calculation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// Contains actions specific for `Calculations`.
/// `Calculations` class is created and used in `AppModel` object.
/// Actions provided by this class should not be called directly from
///  UI layer and should be called only from Main Management class - app_model.dart.
class Calculations {
  API api = API();
  // Categories stream.
  final BehaviorSubject<Map<String, Calculation>> calculationsStream =
      BehaviorSubject<Map<String, Calculation>>();

  Future<Calculation> calculate({
    @required String category,
    @required String formulaName,
    String distance,
    String kw,
  }) async {
    Calculation _calculation;

    // Api call.
    Map response = await api.calculate.calculate(
      category: category,
      formulaName: formulaName,
      distance: distance,
      kw: kw,
    );

    bool status = false;

    if (response.containsKey('status') && response['status'] as bool) {
      status = response['status'];
    }
    if (status) {
      // Get Map data.
      Map<String, dynamic> data = {
        'category': category,
        'co2Count': response['co2Count'],
        'distance': distance,
        'formula_name': formulaName,
        'kw': kw,
        'level': response['level'],
        'message': response['message'],
      };

      // Convert Map to Calculation Model.
      _calculation = Calculation.fromMap(data);

      // Update stream.
      calculationsStream.sink.add({category: _calculation});
    }
    return _calculation;
  }
}
