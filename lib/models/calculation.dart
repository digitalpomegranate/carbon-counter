

import 'package:carbon_counter/base/enums.dart';

/// Calculation model.
class Calculation {
  /// Calculation id.
  final String category;

  /// Calculation type.
  final num co2Count;

  /// Distance [km]
  final String type;

  /// Distance [km]
  final String distance;

  /// Distance [km]
  final String kw;

  /// message
  final String message;

  /// Animation type.
  final CalculationAnimationType animationType;

  /// Creates Calculation object from given Map object
  Calculation.fromMap(Map<String, dynamic> map)
      : category = map['category'],
        co2Count = map['co2Count'],
        distance = map['distance'],
        kw = map['spent_kw'],
        message = map['message'],
        animationType = animationToEnum(map['level']),
        type = map['formula_name'];

  /// Converts the User object to map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) data['category'] = this.category;
    if (this.co2Count != null) data['co2Count'] = this.co2Count;
    if (this.type != null) data['formula_name'] = this.type;
    if (this.kw != null) data['spent_kw'] = this.kw;
    if (this.distance != null) data['distance'] = this.distance;
    if (this.message != null) data['message'] = this.message;
    if (this.animationType != null) data['level'] = enumToString(this.distance);
    return data;
  }
}
