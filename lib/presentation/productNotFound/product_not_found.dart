import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/constants/strings.dart';

class ProductNotFoundPage extends StatelessWidget {
  const ProductNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          Strings.appTitle,
          style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontSize: 31.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'cursive'),
        ),
      ),
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Product Not Found",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            ImageIcon(
              AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
              size: 170.r,
              color: Colors.grey,
            ),
            Text(
              "We couldn't find this product",
              style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
