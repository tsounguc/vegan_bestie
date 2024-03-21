import 'package:flutter/material.dart';
import 'package:sheveegan/core/resources/strings.dart';

class CustomAppbarTitleWidget extends StatelessWidget {
  const CustomAppbarTitleWidget({
    required this.imageOneName,
    required this.imageTwoName,
    super.key,
  });

  final String imageOneName;
  final String imageTwoName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            Image.asset(
              imageTwoName,
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width * 0.07,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
          ],
        ),
      ),
    );
  }
}
