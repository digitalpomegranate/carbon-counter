import 'package:carbon_counter/base/base.dart';

/// Category model.
class Category {
  /// Category id.
  final String id;

  /// Category type.
  final Measure type;

  /// Email address
  final List<String> types;

  /// Creates Category object from given Map object
  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        type = measureStringToEnum(map['id']),
        types = List.generate(
            map['types'].length, (index) => "${map['types'][index]}");

  /// Converts the User object to map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.types != null) data['types'] = this.types;
    return data;
  }
}
