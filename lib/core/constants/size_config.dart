import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    // print("With: $screenWidth");
    // print("Height: $screenHeight");
    // print("Block Horizontal: $blockSizeHorizontal");
    // print("Block Verticcal: $blockSizeVertical");
    // print(
    //     "Button size: ${blockSizeVertical! * 13.5} * 2 = ${blockSizeVertical! * 13.5 * 2}");
  }
}
