import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';
import 'package:sheveegan/home.dart';
import 'package:flutter/services.dart';
import 'package:sheveegan/she_vegan_home_page.dart';
import 'package:sheveegan/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      // child: Home(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SheVegan Home",
        theme: ThemeData(
            primaryColor: Colors.green.shade50,
            primaryColorDark: Colors.green,
            primaryColorLight: Colors.lime,
            textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                fontFamily: 'cursive',
              ),
            )),
        // home: AnimatedSplashScreen(
        //   backgroundColor: gradientStartColor,
        //   splash: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'She ',
        //         style: TextStyle(
        //           color: titleTextColorOne,
        //           // color: Colors.green.shade600,
        //           fontSize: 45,
        //           fontWeight: FontWeight.bold,
        //           fontFamily: 'cursive',
        //         ),
        //       ),
        //       Icon(
        //         VeganIcon.vegan_icon,
        //         color: titleTextColorOne,
        //         size: 38,
        //       ),
        //       Text(
        //         'egan',
        //         style: TextStyle(
        //           color: titleTextColorOne,
        //           fontSize: 45,
        //           fontWeight: FontWeight.bold,
        //           fontFamily: 'cursive',
        //         ),
        //       ),
        //     ],
        //   ),
        //   nextScreen: SheVeganHomePage(),
        // ),
        home: SheVeganHomePage(),
      ),
    ),
  );
}
