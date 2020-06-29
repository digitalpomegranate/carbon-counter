import 'package:carbon_counter/management/management.dart';
import 'package:carbon_counter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../base/enums.dart';

/// Contains actions specific for `Users`.
/// `Users` class is created and used in `AppModel` object.
/// Actions provided by this class should not be called directly from
///  UI layer and should be called only from Main Management class - app_model.dart.
class Users {
  static const USERS_TABLE = "users";
  // Signed user stream.

  Stream<User> userStream;

  Future<User> get currentUser => _getUser();

  // Future<void> initUserStream() async {
  //   // Get signed user.
  //   FirebaseUser _firebaseUser = await FirebaseAuth.instance.currentUser();

  //   // User object.
  //   User user;

  //   // If signed user exists.
  //   if (_firebaseUser != null) {
  //     // Listen changed users table.
  //     userStream = Firestore.instance
  //         .collection(USERS_TABLE)
  //         .document(_firebaseUser.uid)
  //         .snapshots()
  //         .map<User>((userDoc) => User.fromMap(userDoc.data));
  //   }
  // }

  ///
  /// [getUserData] function get signed user data.
  ///
  Future<User> _getUser() async {
    // Get signed user.
    FirebaseUser _firebaseUser = await FirebaseAuth.instance.currentUser();

    // User object.
    User user;

    // If signed user exists.
    if (_firebaseUser?.uid != null) {
      // Set user object.
      DocumentSnapshot documentSnapshot = await Firestore.instance
          .collection(USERS_TABLE)
          .document(_firebaseUser.uid)
          .get();

      if (documentSnapshot?.data != null &&
          documentSnapshot.data['id'] != null) {
        Map data = {
          'id': _firebaseUser.uid,
          'email': _firebaseUser.email,
        };
        user = User.fromMap(documentSnapshot.data ?? data);
      }
    }
    return user;
  }

  Future<String> createUser(
      {String email,
      String password,
      String role,
      String companyName,
      String fullname}) async {
    User user;

    String errorMessage;

    AuthResult authResult;

    try {
      authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      print("Error in createUserWithEmailAndPassword() function: $e");
      return "Something went wrong during user creating.";
    }

    if (authResult?.user != null) {
      DocumentReference userDocRef =
          Firestore.instance.collection('users').document(authResult.user.uid);
      user = User(
          email: email,
          role: role,
          companyName: companyName,
          fullname: fullname,
          id: authResult.user.uid,
          status: UserStatus.EmailNotVerified);
      authResult.user.sendEmailVerification();

      userDocRef.setData(user.toMap());
      // Update user stream when user has been created.
      userStream = userDocRef
          .snapshots()
          .map<User>((userDoc) => User.fromMap(userDoc.data))
          .asBroadcastStream();

      AppModel().plans.createPlansDocument(user.id);
    }

    return errorMessage;
  }

  Future<String> signIn({String email, String password}) async {
    User user;

    String errorMessage;
    AuthResult authResult;
    try {
      authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      print("Error in signInWithEmailAndPassword() function: $e");
      return "Something went wrong during sign in.";
    }

    if (authResult?.user != null) {
      DocumentReference userDocRef =
          Firestore.instance.collection('users').document(authResult.user.uid);
      // Check if email is verified then log in user to the App, else send one more email verification.
      if (authResult.user.isEmailVerified) {
        userDocRef.setData({'status': "LoggedIn"}, merge: true);
      } else {
        errorMessage = "Email is not verified.";
        // authResult.user.sendEmailVerification();
      }

      // Update user stream when user has been created.
      userStream = userDocRef
          .snapshots()
          .map<User>((userDoc) => User.fromMap(userDoc.data))
          .asBroadcastStream();
    }

    return errorMessage;
  }

  _handleSignUpExceptions(PlatformException e) {
    switch (e.code) {
      case "ERROR_WEAK_PASSWORD":
        //return custom message.
        break;
      case "ERROR_INVALID_EMAIL":
        //return custom message.

        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        //return custom message.

        break;
    }
  }
}
