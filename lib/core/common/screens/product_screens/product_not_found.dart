import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/constants/strings.dart';

import '../../widgets/custom_back_button.dart';

class ProductNotFoundPage extends StatelessWidget {
  final String? message;

  const ProductNotFoundPage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: CustomBackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            Spacer(),
            Text(
              Strings.productNotFound,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Spacer(),
            ImageIcon(
              AssetImage('assets/logo/VeganBestieLogo.png'),
              size: MediaQuery.of(context).size.width * 0.55,
              color: Colors.grey,
            ),
            Spacer(),
            SizedBox(
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "We were not able to find",
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
            // Spacer(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Please try again or ",
            //       style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.of(context).pushNamed(ReportIssuePage.id);
            //       },
            //       style: ButtonStyle(
            //           padding: MaterialStateProperty.all(EdgeInsets.zero)),
            //       child: Text(
            //         Strings.reportIssueText,
            //         style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 15.sp,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline,
            //             decorationThickness: 2),
            //       ),
            //     )
            //   ],
            // ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
