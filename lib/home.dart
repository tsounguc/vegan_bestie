import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/she_vegan_home_page.dart';

class Home extends HookWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SheVegan Home",
      theme: ThemeData(
        primaryColor: Colors.green.shade50,
        primaryColorDark: Colors.green,
        primaryColorLight: Colors.lime,
        textTheme: TextTheme(headline1: TextStyle(
          color: Colors.black,
          fontSize: 27,
          fontWeight: FontWeight.bold,
          fontFamily: 'cursive',
        ),)
      ),
      home: SheVeganHomePage(),
    );
  }
}
