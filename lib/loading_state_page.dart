import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheveegan/colors.dart';

class LoadingStatePage extends HookWidget {
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
