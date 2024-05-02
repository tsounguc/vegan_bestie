import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/food_product/presentation/pages/scan_results_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/scan_product_cubit.dart';
import 'package:sheveegan/themes/app_theme.dart';
import 'package:simple_animations/simple_animations.dart';

class ScanProductHomePage extends StatelessWidget {
  const ScanProductHomePage({super.key});

  static const String id = '/scanProductHomePage';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanProductCubit, ScanProductState>(
      listener: (blocContext, state) {
        if (state is BarcodeFound) {
          BlocProvider.of<ScanProductCubit>(
            context,
          ).fetchProduct(barcode: state.barcode);
        } else if (state is FoodProductError) {
          debugPrint(state.message);
          CoreUtils.showSnackBar(
            context,
            state.message,
          );
        } else if (state is FetchingProduct) {
          Navigator.of(context).pushNamed(
            ScanResultsPage.id,
            arguments: context.read<ScanProductCubit>(),
          );
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
                      return Container(
                        width: value,
                        height: value,
                        color: Colors.white,
                        child: animationChild,
                      );
                    },
                    child: ElevatedButton(
                      onPressed: () async {
                        await BlocProvider.of<ScanProductCubit>(
                          context,
                        ).scanBarcode();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(6),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromRadius(90.r),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        surfaceTintColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0.r),
                          child: ImageIcon(
                            const AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                            size: 170.0.r,
                            color: Colors.blueGrey.shade900,
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
