import 'package:carbon_counter/base/colors.dart';
import 'package:flutter/material.dart';

/// This class contains all app themes.
/// All app/text specific colors should be defined here.
/// Text widgets should get the themes from this class.
class AppThemes {
  // Fonts
  static String primaryFontFamily = 'Amatic';
  static String secondaryFontFamily = 'Baloo';

  // App default theme
  static ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: AppColors.green,
      accentColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.white,
      primaryTextTheme: TextTheme(
        overline: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 1.5,
          fontSize: 10,
        ),
        caption: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0.4,
          fontSize: 12,
        ),
        button: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_MEDIUM,
          color: AppColors.black,
          letterSpacing: 1.25,
          fontSize: 14,
        ),
        bodyText2: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0.25,
          fontSize: 14,
        ),
        bodyText1: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
        subtitle2: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_MEDIUM,
          color: AppColors.black,
          letterSpacing: 0.1,
          fontSize: 14,
        ),
        subtitle1: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0.15,
          fontSize: 16,
        ),
        headline6: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_MEDIUM,
          color: AppColors.black,
          letterSpacing: 0.15,
          fontSize: 20,
        ),
        headline5: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0,
          fontSize: 24,
        ),
        headline4: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0.25,
          fontSize: 34,
        ),
        headline3: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: 0,
          fontSize: 48,
        ),
        headline2: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: -0.5,
          fontSize: 60,
        ),
        headline1: TextStyle(
          fontFamily: primaryFontFamily,
          fontWeight: FONTWEIGHT_REGULAR,
          color: AppColors.black,
          letterSpacing: -1.5,
          fontSize: 96,
        ),
      ),
    );
  }

  // Font weights
  static const FontWeight FONTWEIGHT_THIN = FontWeight.w100;
  static const FontWeight FONTWEIGHT_EXTRA_LIGHT = FontWeight.w200;
  static const FontWeight FONTWEIGHT_LIGHT = FontWeight.w300;
  static const FontWeight FONTWEIGHT_REGULAR = FontWeight.w400;
  static const FontWeight FONTWEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight FONTWEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight FONTWEIGHT_BOLD = FontWeight.w700;
  static const FontWeight FONTWEIGHT_EXTRA_BOLD = FontWeight.w800;
  static const FontWeight FONTWEIGHT_BLACK = FontWeight.w900;

  // Opacities
  static const double OPACITY_LOW = 0.35;
  static const double OPACITY_MIDDLE = 0.5;
  static const double OPACITY_HIGH = 0.9;
}
