import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import 'constants/strings.dart';

class VeganBestieLogoWidget extends StatelessWidget {
  double? size;

  VeganBestieLogoWidget({Key? key, this.size = 35}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.appTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.lightPrimaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
