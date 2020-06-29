import 'package:carbon_counter/base/regexp.dart';
import 'package:flutter/material.dart';

import '../localization/localizations.dart';

class InputValidators {
  AppLocalizations locals = AppLocalizations();

  ///
  /// [email] function will be validate received email.
  ///
  /// Function gets na arguments:
  /// * `@required` `String` `email`.
  ///
  /// `email` must be match [RegularExpressions.emailForm] form.
  ///
  /// Function should check validity and should
  /// return error message as type of `String`.
  ///
  /// If returned value is `null` it means value is valid.
  ///
  String email({@required String email}) {
    String message = locals.invalidEmail;
    if (email.trim().isEmpty) {
      message = locals.requiedField;
    } else if (RegularExpressions.email.hasMatch(email)) {
      message = null;
    }
    return message;
  }

  ///
  /// [password] function will be validate received password.
  ///
  /// Function gets na arguments:
  /// * `@required` `String` `password`.
  ///
  /// `password` must be match [RegularExpressions.password] form.
  ///
  /// Function should check validity and should
  /// return error message as type of `String`.
  ///
  /// If returned value is `null` it means value is valid.
  ///
  String password({@required String password}) {
    String message = locals.invalidPassword;
    if (RegularExpressions.password.hasMatch(password)) {
      message = null;
    }
    return message;
  }

  ///
  /// [username] function will be validate received username.
  ///
  /// Function gets na arguments:
  /// * `@required` `String` `username`.
  ///
  /// `username` must be contains minimum `4` characters.
  ///
  /// Function should check validity and should
  /// return error message as type of `String`.
  ///
  /// If returned value is `null` it means value is valid.
  ///
  String username({@required String username}) {
    String message = locals.invalidUsername;
    if (username.trim().isEmpty) {
      message = locals.requiedField;
    } else if (username.length >= 4) {
      message = null;
    }
    return message;
  }

  ///
  /// [isNotEmpty] function will be validate received text field.
  ///
  /// Function gets na arguments:
  /// * `@required` `String` `text`.
  ///

  ///
  /// Function should check validity and should
  /// return error message as type of `String`.
  ///
  /// If returned value is `null` it means value is valid.
  ///
  String isNotEmpty({@required String text}) {
    String message;
    if (text.trim().isEmpty) {
      message = locals.requiedField;
    }
    return message;
  }
}
