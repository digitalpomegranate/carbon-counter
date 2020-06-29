import 'package:carbon_counter/base/enums.dart';

/// Cloud API User object.
class User {
  /// Cloud-generated UUID of the instance
  final String id;

  /// Email address
  final String email;

  /// Nick name.
  final String fullname;

  /// Role.
  final String role;

  /// Cities.
  final String companyName;

  UserStatus status;

  /// Default `User` constructor.
  User({
    this.id,
    this.email,
    this.companyName,
    this.fullname,
    this.role,
    this.status,
  });

  /// Creates User object from given Map object
  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        companyName = map['company_name'],
        fullname = map['full_name'],
        role = map['role'],
        status = _convertStatusFromString(statusInString:map['status']);

  /// Converts the User object to map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.email != null) data['email'] = this.email;
    if (this.companyName != null) data['company_name'] = this.companyName;
    if (this.fullname != null) data['full_name'] = this.fullname;
    if (this.role != null) data['role'] = this.role;
    if (this.status != null) data['status'] = this.status.toString().split(".").last;
    return data;
  }

  static _convertStatusFromString({String statusInString}){
    switch (statusInString) {
      case "LoggedIn":
        return UserStatus.LoggedIn;
        break;
      case "EmailNotVerified":
                return UserStatus.EmailNotVerified;

        break;
      case "LoggedOut":
                return UserStatus.LoggedOut;

        break;
      default:
    }

    return "Undefined";
  }
}


