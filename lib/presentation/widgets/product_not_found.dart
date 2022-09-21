import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/constants/strings.dart';

class ProductNotFoundPage extends StatelessWidget {
  final String? message;
  const ProductNotFoundPage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Spacer(),
            Text(
              "Product Not Found",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Spacer(),
            ImageIcon(
              AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
              size: 170.r,
              color: Colors.grey,
            ),
            Spacer(),
            SizedBox(
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "We were not able find",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    this.message ?? "this product",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  )
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
