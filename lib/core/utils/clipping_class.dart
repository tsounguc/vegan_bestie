import 'dart:ui';

import 'package:flutter/material.dart';

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;
    // (0, 0) // 1. Point
    path.lineTo(0, height - 75); // 2. Point
    path.quadraticBezierTo(
      width / 4, // 3. point
      height - 150, // 3. point
      width / 2, // 4. point
      height - 100, // 4. point
    );
    path.quadraticBezierTo(
      width * 3 / 4, // 5. point
      height - 50, // 5. point
      width * 4 / 4, // 6. point
      height - 125, // 6. point
    );
    path.lineTo(width, 0);
    path.close();
//
//     path.lineTo(0.0, size.height * 80 / 100);
//     path.lineTo(size.width * 75 / 100, size.height * 71.5 / 100);
//     double rangeX = size.width * 87.5 / 100;
//     double rangeY = size.height * 70.5 / 100;
//     double givenPointX = size.width * 92.5 / 100;
//     double givenPointY = size.height * 60 / 100;
//     path.quadraticBezierTo(rangeX, rangeY, givenPointX, givenPointY);
    // double rangeX1 = size.width * 95 / 100;
    // double rangeY1 = size.height * 55 / 100;
    // double givenPointX1 = size.width * 96 / 100;
    // double givenPointY1 = size.height * 49 / 100;
    // path.quadraticBezierTo(rangeX1, rangeY1, givenPointX1, givenPointY1);
    // path.lineTo(size.width * 1.02, 0);
    // path.lineTo(size.width - 10, size.height / 4);
//
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ClippingClassTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;
    // (0, 0) // 1. Point
    path.lineTo(0, height / 2); // 2. Point
    path.quadraticBezierTo(
      width / 2, // 3. point
      height / 4, // 3. point
      width / 2, // 4. point
      height / 1.5, // 4. point
    );
    path.quadraticBezierTo(
      width / 4, // 5. point
      height * 3 / 4, // 5. point
      0, // 6. point
      height, // 6. point
    );
    path.lineTo(0, height);
    path.close();
//
//     path.lineTo(0.0, size.height * 80 / 100);
//     path.lineTo(size.width * 75 / 100, size.height * 71.5 / 100);
//     double rangeX = size.width * 87.5 / 100;
//     double rangeY = size.height * 70.5 / 100;
//     double givenPointX = size.width * 92.5 / 100;
//     double givenPointY = size.height * 60 / 100;
//     path.quadraticBezierTo(rangeX, rangeY, givenPointX, givenPointY);
    // double rangeX1 = size.width * 95 / 100;
    // double rangeY1 = size.height * 55 / 100;
    // double givenPointX1 = size.width * 96 / 100;
    // double givenPointY1 = size.height * 49 / 100;
    // path.quadraticBezierTo(rangeX1, rangeY1, givenPointX1, givenPointY1);
    // path.lineTo(size.width * 1.02, 0);
    // path.lineTo(size.width - 10, size.height / 4);
//
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
