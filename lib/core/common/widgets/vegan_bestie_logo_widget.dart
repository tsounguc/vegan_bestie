import 'package:flutter/material.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
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
              MediaResources.tofu,
              fit: BoxFit.contain,
              height: size,
              width: size,
            ),
            Image.asset(
              MediaResources.broccoli,
              fit: BoxFit.contain,
              height: size,
              width: size,
            ),
            Image.asset(
              MediaResources.avocado,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
