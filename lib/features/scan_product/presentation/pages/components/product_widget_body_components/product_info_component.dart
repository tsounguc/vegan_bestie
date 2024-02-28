import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';
import 'package:sheveegan/core/utils/colors.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/core/utils/strings.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/product_found_tabbar_view.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductInfoComponent extends StatelessWidget {
  const ProductInfoComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const tabBarViewMode = false;
    SizeConfig().init(context);
    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is ProductFound) {
          final proteinsAmount = state.product.proteins100G;
          final carbsAmount = state.product.carbohydrates100G;
          final fatAmount = state.product.fat100G;
          final total = proteinsAmount + carbsAmount + fatAmount;
          final proteinsPct = proteinsAmount / total * 100;
          final carbsPct = carbsAmount / total * 100;
          final fatPct = fatAmount / total * 100;
          return Container(
            padding: const EdgeInsets.only(
              top: 35,
              left: 35,
              right: 35,
              bottom: 35,
            ),
            height: MediaQuery
                .of(context)
                .size
                .height * .60,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.r),
                topRight: Radius.circular(35.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: state.product.ingredientsText.isNotEmpty,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.isVegan)
                        Tooltip(
                          height: 50.h,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          textAlign: TextAlign.start,
                          message: Strings.toolTipVeganMessage,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const BoxDecoration(color: Colors.green),
                          showDuration: const Duration(seconds: 5),
                          child: Icon(
                            VeganIcon.vegan_icon,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background,
                            size: 30.r,
                          ),
                        ),
                      if (!state.isVegan)
                        Tooltip(
                          decoration: const BoxDecoration(color: Colors.red),
                          height: 50.h,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          textAlign: TextAlign.start,
                          message: "She ain't Vegan 😞 \ncontains "
                              '${state.nonVeganIngredients} ',
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          showDuration: const Duration(seconds: 5),
                          child: Icon(
                            Icons.not_interested_outlined,
                            size: 30.r,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                Visibility(
                  visible: tabBarViewMode,
                  child: Expanded(
                    child: ProductFoundTabBarView(
                      product: state.product,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          state.product.productName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: state.isVegan ? Theme
                                .of(context)
                                .colorScheme
                                .background : Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Barcode - ${state.product.code}',
                      style: TextStyle(
                        fontSize: 16,
                        color: state.isVegan ? Theme
                            .of(context)
                            .colorScheme
                            .background : Colors.red.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      height: 80,
                      width: 55,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                              color: proteinsColor,
                              value: state.product.proteins100G,
                              radius: 20,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              color: carbsColor,
                              value: state.product.carbohydrates100G,
                              radius: 20,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              color: fatColor,
                              value: state.product.fat100G,
                              radius: 20,
                              showTitle: false,
                            ),
                          ],
                        ),
                        swapAnimationDuration: const Duration(seconds: 3),
                        swapAnimationCurve: Curves.bounceIn,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Proteins (${proteinsPct.toStringAsFixed(1)}%): '
                              '${proteinsAmount.toStringAsFixed(1)} '
                              '${state.product.proteinsUnit}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: proteinsColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Carbs (${carbsPct.toStringAsFixed(1)}%): '
                              '${carbsAmount.toStringAsFixed(1)} '
                              '${state.product.carbohydratesUnit}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: carbsColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Fat (${fatPct.toStringAsFixed(1)}%): '
                              '${fatAmount.toStringAsFixed(1)} '
                              '${state.product.fatUnit} ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: fatColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Text(
                    'Ingredients: ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: state.isVegan ? Theme
                          .of(context)
                          .colorScheme
                          .background : Colors.red.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0.w,
                        right: 48.0.w,
                      ),
                      child: Text(
                        state.product.ingredientsText.isNotEmpty
                            ? state.product.ingredientsText
                            : 'Ingredients not found'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: state.isVegan ? Theme
                              .of(context)
                              .colorScheme
                              .background : Colors.red.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        state.product.labels,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
