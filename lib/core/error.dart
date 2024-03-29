import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/constants/strings.dart';
import 'package:sheveegan/core/product_not_found.dart';

class ErrorPage extends StatelessWidget {
  final dynamic error;
  const ErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error.contains(Strings.productNotFound)) {
      return ProductNotFoundPage();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Flexible(
              child: Text(
                '$error',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
