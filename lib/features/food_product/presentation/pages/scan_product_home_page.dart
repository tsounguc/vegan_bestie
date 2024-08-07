import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/themes/app_theme.dart';
import 'package:simple_animations/simple_animations.dart';

class ScanProductHomePage extends StatelessWidget {
  const ScanProductHomePage({super.key});

  static const String id = '/scanProductHomePage';

  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodProductCubit, FoodProductState>(
      listener: (blocContext, state) {
        if (state is BarcodeFound) {
          BlocProvider.of<FoodProductCubit>(
            context,
          ).fetchProduct(barcode: state.barcode);
        } else if (state is FoodProductError) {
          debugPrint(state.message);
          CoreUtils.showSnackBar(
            context,
            state.message,
          );
        } else if (state is FetchingProduct) {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
          Navigator.of(context).pushNamed(
            LoadingPage.id,
          );
        } else if (state is ProductFound) {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/'),
          );
          Navigator.of(context).pushNamed(
            ProductFoundPage.id,
            arguments: state.product,
          );
        }
        if (state is SavedProductsListFetched) {
          context.savedProductsProvider.savedProductsList = state.savedProductsList;
        }
        if (state is ReportsFetched) {
          context.reportsProvider.reports = state.reports;
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 56.h,
            right: 16.w,
            bottom: 8.h,
            left: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // height: 100 - toolbarHeight,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const VeganBestieLogoWidget(size: 45),
              SizedBox(
                // height: 100,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Column(
                children: [
                  Text(
                    Strings.tapToScan,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  CustomAnimationBuilder<double>(
                    control: Control.mirror,
                    tween: Tween(
                      begin: context.width * 0.55,
                      end: context.width * 0.53,
                      // begin: 200.r,
                      // end: 185.r,
                    ),
                    duration: const Duration(milliseconds: 1000),
                    delay: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    // animationStatusListener: (status) {
                    //   print('Status update: $status');
                    // },
                    builder: (animationContext, value, animationChild) {
                      return SizedBox(
                        width: value,
                        height: value,
                        // color: Colors.white,
                        child: animationChild,
                      );
                    },
                    child: ElevatedButton(
                      onPressed: () async {
                        await BlocProvider.of<FoodProductCubit>(
                          context,
                        ).scanBarcode();
                      },
                      style: ElevatedButton.styleFrom(
                          // elevation: 6,
                          // shadowColor: MaterialStateProperty.all(Colors.black),
                          // fixedSize: Size.fromRadius(90.r),
                          // backgroundColor: context.theme.cardTheme.color,
                          // surfaceTintColor: context.theme.cardTheme.color,
                          // shape: const CircleBorder(),
                          ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0.r),
                          child: ImageIcon(
                            const AssetImage(MediaResources.scannerLogo),
                            size: 170.0.r,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                // height: 100 - toolbarHeight,
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
