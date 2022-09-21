import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  const AppTheme._();

  static Color lightBackgroundColor = const Color(0XFF2E7D32);
  static Color lightPrimaryColor = const Color(0XFF2E7D32);
  static Color lightAccentColor = Colors.greenAccent;
  static Color lightParticles = Colors.green.shade900;

  static Color darkBackgroundColor = Colors.green.shade900;
  static Color darkPrimaryColor = Colors.green.shade900;
  static Color darkAccentColor = Colors.greenAccent.shade700;
  static Color darkParticles = const Color(0XFF2E7D32);

  static final lightTheme = ThemeData(
    primarySwatch: MaterialColor(0XFF2E7D32, <int, Color>{
      50: Colors.green.shade50,
      100: Colors.green.shade100,
      200: Colors.green.shade200,
      300: Colors.green.shade300,
      400: Colors.green.shade400,
      500: Colors.green.shade500,
      600: Colors.green.shade600,
      700: Colors.green.shade700,
      800: Colors.green.shade800,
      900: Colors.green.shade900,
    }),
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: lightPrimaryColor,
        secondary: lightAccentColor,
        background: lightBackgroundColor),
    backgroundColor: lightPrimaryColor,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 27,
        fontWeight: FontWeight.bold,
        fontFamily: 'cursive',
      ),
    ),
    iconTheme: IconThemeData(color: lightParticles),
    snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: MaterialColor(0XFF2E7D32, <int, Color>{
      50: Colors.green.shade50,
      100: Colors.green.shade100,
      200: Colors.green.shade200,
      300: Colors.green.shade300,
      400: Colors.green.shade400,
      500: Colors.green.shade500,
      600: Colors.green.shade600,
      700: Colors.green.shade700,
      800: Colors.green.shade800,
      900: Colors.green.shade900,
    }),
    // splashColor: Colors.transparent,
    // highlightColor: Colors.transparent,
    // hoverColor: Colors.transparent,
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        background: darkBackgroundColor),
    backgroundColor: darkPrimaryColor,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 27.sp,
        fontWeight: FontWeight.bold,
        fontFamily: 'cursive',
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(color: Colors.white)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: themeMode == ThemeMode.light ? lightBackgroundColor : darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent));
  }
}
