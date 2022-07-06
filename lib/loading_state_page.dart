import 'package:flutter/material.dart';
import 'package:sheveegan/constants/colors.dart';

class LoadingStatePage extends StatelessWidget {
  const LoadingStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gradientStartColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 6,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
