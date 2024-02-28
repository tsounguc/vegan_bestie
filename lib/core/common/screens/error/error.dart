import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/core/utils/strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required this.error,
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    if (error.contains(Strings.productNotFound)) {
      return const ProductNotFoundPage();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Flexible(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
