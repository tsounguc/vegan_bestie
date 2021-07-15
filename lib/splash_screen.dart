import 'package:flutter/material.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: gradientStartColor),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'She ',
                  style: TextStyle(
                    color: titleTextColorOne,
                    // color: Colors.green.shade600,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                  ),
                ),
                Icon(
                  VeganIcon.vegan_icon,
                  color: titleTextColorOne,
                  size: 30,
                ),
                Text(
                  'egan',
                  style: TextStyle(
                    color: titleTextColorOne,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cursive',
                  ),
                ),
              ],
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
