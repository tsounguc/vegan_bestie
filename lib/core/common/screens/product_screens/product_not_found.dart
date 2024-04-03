import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/resources/strings.dart';

class ProductNotFoundPage extends StatelessWidget {
  const ProductNotFoundPage({super.key, this.message});

  static const String id = '/productNotFoundPage';

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: const CustomBackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // Spacer(),
            const Spacer(),
            Text(
              Strings.productNotFound,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const Spacer(),
            ImageIcon(
              const AssetImage('assets/logo/VeganBestieLogo.png'),
              size: MediaQuery.of(context).size.width * 0.55,
              color: Colors.grey,
            ),
            const Spacer(),
            SizedBox(
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'We were not able to find',
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    message ?? 'this product',
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
