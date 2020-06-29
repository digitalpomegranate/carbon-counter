import 'dart:async';
import 'package:carbon_counter/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'login',
    );
  }

  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'register',
    );
  }

  String get carbonCounter {
    return Intl.message(
      'Carbon Counter',
      name: 'carbonCounter',
      desc: 'carbonCounter',
    );
  }

  String get companyName {
    return Intl.message(
      'Company name',
      name: 'companyName',
      desc: 'companyName',
    );
  }

  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: 'fullName',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'email',
    );
  }

  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: 'role',
    );
  }

  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: 'back',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'password',
    );
  }

  String get hack20 {
    return Intl.message(
      '#Hack20',
      name: 'hack20',
      desc: 'hack20',
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: 'invalidEmail',
    );
  }

  String get invalidUsername {
    return Intl.message(
      'Invalid Username',
      name: 'invalidUsername',
      desc: 'invalidUsername',
    );
  }

  String get invalidPassword {
    return Intl.message(
      'Password should have at least 1 uppercase, 1 lowercase and 1 digit number. Password cannot be less than 6 characters.',
      name: 'invalidPassword',
      desc: 'invalidPassword',
    );
  }

  String get requiedField {
    return Intl.message(
      'This field is required.',
      name: 'requiedField',
      desc: 'requiedField',
    );
  }

  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: 'ok',
    );
  }

  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: 'loading',
    );
  }

  String get distance {
    return Intl.message(
      'Distance [km]',
      name: 'distance',
      desc: 'distance',
    );
  }

  String get calculate {
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: 'calculate',
    );
  }

  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: 'play',
    );
  }

  String get challenges {
    return Intl.message(
      'Challenges',
      name: 'challenges',
      desc: 'challenges',
    );
  }

  String get teams {
    return Intl.message(
      'Teams',
      name: 'teams',
      desc: 'teams',
    );
  }

  String get competitions {
    return Intl.message(
      'Competitions',
      name: 'competitions',
      desc: 'competitions',
    );
  }

  String get leaderboard {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboard',
      desc: 'leaderboard',
    );
  }

  String get challengesDescription {
    return Intl.message(
      'Join local challenges to make your environment greener. Complete them to win benefits.',
      name: 'challengesDescription',
      desc: 'challengesDescription',
    );
  }

  String get teamsDescription {
    return Intl.message(
      'Create your teams to join group challenges.',
      name: 'teamsDescription',
      desc: 'teamsDescription',
    );
  }

  String get competitionsDescription {
    return Intl.message(
      'Participate public competitions to communicate with other participants. Find now friends and help your community.',
      name: 'competitionsDescription',
      desc: 'competitionsDescription',
    );
  }

  String get leaderboardsDescription {
    return Intl.message(
      'Track your achievments...',
      name: 'leaderboardsDescription',
      desc: 'leaderboardsDescription',
    );
  }

  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: 'join',
    );
  }

  String get offset {
    return Intl.message(
      'Offset',
      name: 'offset',
      desc: 'offset',
    );
  }

  String get measure {
    return Intl.message(
      'Measure',
      name: 'measure',
      desc: 'measure',
    );
  }

  String get plan {
    return Intl.message(
      'Plan',
      name: 'plan',
      desc: 'plan',
    );
  }

  String get reduce {
    return Intl.message(
      'Reduce',
      name: 'reduce',
      desc: 'reduce',
    );
  }

  String get comply {
    return Intl.message(
      'Comply',
      name: 'comply',
      desc: 'comply',
    );
  }

  String get transportation {
    return Intl.message(
      'Transportation',
      name: 'transportation',
      desc: 'transportation',
    );
  }

  String get electricity {
    return Intl.message(
      'Electricity',
      name: 'electricity',
      desc: 'electricity',
    );
  }

  String get comingSoon {
    return Intl.message(
      'Coming soon...',
      name: 'comingSoon',
      desc: 'comingSoon',
    );
  }

  String get startBenefit {
    return Intl.message(
      'Start Benefit',
      name: 'startBenefit',
      desc: 'startBenefit',
    );
  }

  String get finishBenefit {
    return Intl.message(
      'Finish Benefit',
      name: 'finishBenefit',
      desc: 'finishBenefit',
    );
  }

  String get ecoBenefit {
    return Intl.message(
      'Eco Benefit',
      name: 'ecoBenefit',
      desc: 'ecoBenefit',
    );
  }

  String get moneyBenefit {
    return Intl.message(
      'Money Benefit',
      name: 'moneyBenefit',
      desc: 'moneyBenefit',
    );
  }

  String get plans {
    return Intl.message(
      'Plans',
      name: 'Plans',
      desc: 'Plans',
    );
  }

  String get save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: 'Save',
    );
  }

  String get noPlansText {
    return Intl.message(
      "You don't have any plans yet. Create new one by clicking '+' button!",
      name:
          "You don't have any plans yet. Create new one by clicking '+' button!",
      desc:
          "You don't have any plans yet. Create new one by clicking '+' button!",
    );
  }
  //

  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: 'water',
    );
  }

  String get attention {
    return Intl.message(
      'Attention!',
      name: 'attention',
      desc: 'attention',
    );
  }

  String get verifyEmail {
    return Intl.message(
      'Please verify email by following the link sent to your Email, then sign in!',
      name: 'verifyEmail',
      desc: 'verifyEmail',
    );
  }

  String get errorDuringSignUp {
    return Intl.message(
      'Error during sign up.',
      name: 'errorDuringSignUp',
      desc: 'errorDuringSignUp',
    );
  }

  String get errorDuringSignIn {
    return Intl.message(
      'Error during sign in.',
      name: 'errorDuringSignIn',
      desc: 'errorDuringSignIn',
    );
  }

  String get carbonEmission {
    return Intl.message(
      'Carbon Emission',
      name: 'carbonEmission',
      desc: 'carbonEmission',
    );
  }

  String get carbonEmissionOffsetOptions {
    return Intl.message(
      'Carbon emission offset options',
      name: 'carbonEmissionOffsetOptions',
      desc: 'carbonEmissionOffsetOptions',
    );
  }

  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: 'monday',
    );
  }

  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: 'tuesday',
    );
  }

  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: 'wednesday',
    );
  }

  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: 'thursday',
    );
  }

  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: 'friday',
    );
  }

  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: 'saturday',
    );
  }

  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: 'sunday',
    );
  }

  String get num1350 {
    return Intl.message(
      '1,350',
      name: 'num1350',
      desc: 'num1350',
    );
  }

  String get offsetPoints {
    return Intl.message(
      'offset points',
      name: 'offsetPoints',
      desc: 'offsetPoints',
    );
  }

  String get carbonFootprint {
    return Intl.message(
      'carbon footprint',
      name: 'carbonFootprint',
      desc: 'carbonFootprint',
    );
  }

  String get dailyActivitiesOptions {
    return Intl.message(
      'Carbon emission offset options for daily activities',
      name: 'dailyActivitiesOptions',
      desc: 'dailyActivitiesOptions',
    );
  }

  String get challangeSbt {
    return Intl.message(
      'Plant One Million Trees Till #Hack21',
      name: 'Plant One Million Trees Till #Hack21',
      desc: 'Plant One Million Trees Till #Hack21',
    );
  }

  String get challenge {
    return Intl.message(
      'Challenge',
      name: 'Challenge',
      desc: 'Challenge',
    );
  }

  String get acceptChallenge {
    return Intl.message(
      'Accept challenge',
      name: 'Accept challenge',
      desc: 'Accept challenge',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
