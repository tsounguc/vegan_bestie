import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  // static Color lightBackgroundColor = const Color(0XFF2E7D32);
  static Color lightBackgroundColor = Colors.white;

  static Color lightPrimaryColor = const Color(0XFF66b032);
  static Color lightSecondaryColor = Colors.green.shade300;
  static Color lightAccentColor = Colors.greenAccent;
  static Color lightParticles = Colors.green.shade900;

  static Color darkBackgroundColor = const Color(0xFF121212);

  static Color darkPrimaryColor = const Color(0XFF66b032);
  static Color darkSecondaryColor = Colors.green.shade300;
  static Color darkAccentColor = Colors.greenAccent;
  static Color darkParticles = const Color(0XFF2E7D32);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: MaterialColor(lightPrimaryColor.value, <int, Color>{
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
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: lightBackgroundColor,
      surfaceTintColor: lightBackgroundColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightBackgroundColor,
      selectedItemColor: lightPrimaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
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
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor: MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: MaterialStatePropertyAll(lightBackgroundColor),
        minimumSize: const MaterialStatePropertyAll(Size(130, 50)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: Colors.grey.shade800,
            fontSize: 12.sp,
          ),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(),
        ),
        elevation: const MaterialStatePropertyAll(2),
      ),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: TextStyle(color: lightPrimaryColor),
      displayMedium: GoogleFonts.dancingScript().copyWith(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      titleSmall: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
      bodyLarge: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(color: Colors.grey.shade600),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
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
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: darkBackgroundColor,
      surfaceTintColor: darkBackgroundColor,
      titleTextStyle: TextStyle(
        color: Colors.grey.shade100,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackgroundColor,
      selectedItemColor: darkPrimaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      unselectedItemColor: Colors.grey,
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
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor: MaterialStatePropertyAll(Colors.grey),
        backgroundColor: MaterialStatePropertyAll(Colors.grey),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        surfaceTintColor: MaterialStatePropertyAll(darkBackgroundColor),
        minimumSize: const MaterialStatePropertyAll(Size(130, 50)),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: Colors.white,
          ),
        ),
        elevation: const MaterialStatePropertyAll(2),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade800,
      surfaceTintColor: Colors.grey.shade800,
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: const TextStyle(color: Colors.white),
      displayMedium: GoogleFonts.dancingScript().copyWith(
        color: darkPrimaryColor,
        fontWeight: FontWeight.bold,
        // fontFamily: 'cursive',
      ),
      displaySmall: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(color: Colors.grey.shade400),
    ),
  );

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: themeMode == ThemeMode.light ? lightBackgroundColor : darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }
}
