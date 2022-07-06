import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sheveegan/vegan_bestie_navigation.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      // home: VeganBestieNavigation(),
    );
  }
}
