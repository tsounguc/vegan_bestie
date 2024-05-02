import 'package:flutter/material.dart';
import 'package:sheveegan/core/resources/strings.dart';

class VeganBestieLogoWidget extends StatelessWidget {
  const VeganBestieLogoWidget({super.key, this.size = 35, this.fontSize = 52, this.showText = true});

  final double size;
  final double fontSize;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/tofu.png',
              fit: BoxFit.contain,
              height: size,
              width: size,
            ),
            Image.asset(
              'assets/broccoli.png',
              fit: BoxFit.contain,
              height: size,
              width: size,
            ),
            Image.asset(
              'assets/avocado.png',
              fit: BoxFit.contain,
              height: size,
              width: size,
            ),
          ],
        ),
        if (showText)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.appTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: fontSize,
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
