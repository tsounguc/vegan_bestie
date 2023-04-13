import 'package:flutter/material.dart';

import 'constants/strings.dart';

class CustomAppbarTitleWidget extends StatelessWidget {
  final String imageOneName;
  final String imageTwoName;

  const CustomAppbarTitleWidget({Key? key, required this.imageOneName, required this.imageTwoName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageOneName,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width * 0.07,
            width: MediaQuery.of(context).size.width * 0.07,
          ),
          Text(
            Strings.appTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Image.asset(
            imageTwoName,
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width * 0.07,
            width: MediaQuery.of(context).size.width * 0.07,
          ),
        ],
      ),
    );
  }
}
