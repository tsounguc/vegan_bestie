import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheveegan/core/constants/colors.dart';

class AppTheme {
  const AppTheme._();

  // static Color lightBackgroundColor = const Color(0XFF2E7D32);
  static Color lightBackgroundColor = Colors.white;

  static Color lightPrimaryColor = const Color(0XFF2E7D32);
  static Color lightSecondaryColor = Colors.green.shade300;
  static Color lightAccentColor = Colors.greenAccent;
  static Color lightParticles = Colors.green.shade900;

  static Color darkBackgroundColor = Colors.green.shade900;
  static Color darkPrimaryColor = Colors.green.shade900;
  static Color darkAccentColor = Colors.greenAccent.shade700;
  static Color darkParticles = const Color(0XFF2E7D32);

  static final lightTheme = ThemeData(
    primarySwatch: MaterialColor(500, <int, Color>{
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
    appBarTheme: AppBarTheme(elevation: 0, backgroundColor: lightBackgroundColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightPrimaryColor,
      selectedItemColor: lightBackgroundColor,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
      unselectedItemColor: Colors.grey.shade500,
    ),
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      tertiary: lightParticles,
      background: lightBackgroundColor,
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: TextStyle(color: lightPrimaryColor),
      displayMedium: TextStyle(color: lightPrimaryColor, fontWeight: FontWeight.bold, fontFamily: 'cursive'),
      displaySmall: TextStyle(color: lightPrimaryColor, fontWeight: FontWeight.bold, fontFamily: 'cursive'),
      titleLarge: TextStyle(
        color: lightPrimaryColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'cursive',
      ),
      titleMedium: TextStyle(color: lightPrimaryColor, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: lightPrimaryColor, fontSize: 24, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: lightPrimaryColor, fontSize: 16, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: MaterialColor(
      Colors.green.shade900.value,
      <int, Color>{
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
      },
    ),
    appBarTheme: AppBarTheme(elevation: 0, backgroundColor: darkPrimaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.green.shade50,
      selectedItemColor: darkBackgroundColor,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
      unselectedItemColor: Colors.grey.shade500,
    ),
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      primary: darkPrimaryColor,
      secondary: darkAccentColor,
      tertiary: darkParticles,
      background: darkBackgroundColor,
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'cursive'),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'cursive',
      ),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: Colors.black),
    ),
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
