import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_report_model.dart';
import 'package:sheveegan/features/food_product/presentation/pages/update_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

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
    return BlocConsumer<FoodProductCubit, FoodProductState>(
      listener: (context, state) {
        if (state is IssueReported) {
          CoreUtils.showSnackBar(context, state.message);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: const CustomBackButton(),
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
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        message ?? 'this product',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<FoodProductCubit>(context).scanBarcode();
                  },
                  icon: const Icon(Icons.replay),
                  label: Text(
                    'Try again',
                    style: TextStyle(
                      color: context.theme.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: context.theme.primaryColor,
                      decorationThickness: 5,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                StatefulBuilder(
                  builder: (context, refresh) {
                    return state is ReportingIssue
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                surfaceTintColor: Colors.white,
                              ),
                              onPressed: () => context.currentUser != null && context.currentUser!.isAdmin
                                  ? gotoUpdateFoodProductPage(context)
                                  : goToReportIssue(context),
                              icon: const Icon(
                                Icons.report,
                                color: Colors.red,
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
                          );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
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
    final user = context.currentUser;
    final report = const FoodProductReportModel.empty().copyWith(
      barcode: barcode,
      userId: user!.uid,
      userName: user.name,
      doesNotExist: true,
    );

    BlocProvider.of<FoodProductCubit>(context).reportIssue(report);
  }
}
