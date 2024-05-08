import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/presentation/pages/update_food_product_screen.dart';

class ProductNotFoundPage extends StatelessWidget {
  const ProductNotFoundPage({
    this.message,
    this.barcode,
    super.key,
  });

  static const String id = '/productNotFoundPage';

  final String? message;
  final String? barcode;

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
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  surfaceTintColor: Colors.white,
                ),
                onPressed: () => context.currentUser != null && context.currentUser!.isAdmin
                    ? gotoUpdateFoodProductPage(context)
                    : goToReportIssue(context),
                icon: const Icon(
                  Icons.warning_amber,
                  color: Colors.amber,
                ),
                label: Text(
                  context.currentUser!.isAdmin ? 'Fix Issue' : 'Report Issue',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void gotoUpdateFoodProductPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      UpdateFoodProductScreen.id,
      arguments: UpdateFoodProductPageArguments(
        'Edit Product',
        FoodProductModel.empty().copyWith(
          code: barcode,
          imageFrontUrl: '',
          productName: '',
          ingredientsText: '',
        ),
      ),
    );
  }

  void goToReportIssue(BuildContext context) {
    // TODO(Product-Not-Found): Handle goToReportIssue() differently here
    // void goToReportIssue(BuildContext context) {
    //   Navigator.pushNamed(
    //     context,
    //     FoodProductReportScreen.id,
    //     arguments: UpdateFoodProductPageArguments('Edit Product', product),
    //   );
    // }
  }
}
