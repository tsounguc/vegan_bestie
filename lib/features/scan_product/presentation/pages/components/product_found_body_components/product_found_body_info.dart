import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/size_config.dart';
import '../../../../../../core/constants/strings.dart';
import '../../../../../../core/resources/vegan_icon.dart';
import '../../../fetch_product_cubit/product_fetch_cubit.dart';
import '../product_found_tabbar_view.dart';

class ProductFoundBodyInfo extends StatelessWidget {
  const ProductFoundBodyInfo({
    Key? key,
    // this.size,
  }) : super(key: key);

  // final Size? size;

  @override
  Widget build(BuildContext context) {
    bool tabBarViewMode = false;
    SizeConfig().init(context);
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductFoundState) {
          double? total = 0;
          double? proteinsPercentage = 0;
          double? carbohydratesPercentage = 0;
          double? fatPercentage = 0;
          if (state.product.proteins100G != null &&
              state.product.carbohydrates100G != null &&
              state.product.fat100G != null) {
            total = state.product.proteins100G! + state.product.carbohydrates100G! + state.product.fat100G!;
            proteinsPercentage = state.product.proteins100G! / total;
            carbohydratesPercentage = state.product.carbohydrates100G! / total;
            fatPercentage = state.product.fat100G! / total;
          }
          return Container(
            padding: EdgeInsets.only(top: 35, left: 35, right: 35, bottom: 35),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: state.product.ingredientsText != null && state.product.ingredientsText!.isNotEmpty,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.isVegan!)
                        Tooltip(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          textAlign: TextAlign.start,
                          message: Strings.toolTipVeganMessage,
                          textStyle: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(color: Colors.green),
                          child: Icon(
                            VeganIcon.vegan_icon,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .background,
                            size: 30.r,
                          ),
                          showDuration: Duration(seconds: 5),
                        ),
                      if (!state.isVegan!)
                        Tooltip(
                          decoration: BoxDecoration(color: Colors.red),
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          textAlign: TextAlign.start,
                          message: "She ain\'t Vegan 😞 \ncontains ${state.nonVeganIngredientsInProduct!}",
                          textStyle: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
                          child: Icon(
                            Icons.not_interested_outlined,
                            size: 30.r,
                            color: Colors.red,
                          ),
                          showDuration: Duration(seconds: 5),
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
                          '${state.product.productName}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: state.isVegan! ? Theme
                                .of(context)
                                .colorScheme
                                .background : Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Barcode - ${state.product.code}',
                      style: TextStyle(
                        fontSize: 16,
                        color: state.isVegan! ? Theme
                            .of(context)
                            .colorScheme
                            .background : Colors.red.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Visibility(
                  visible: state.product.proteins100G != null &&
                      state.product.carbohydrates100G != null &&
                      state.product.fat100G != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        height: 80,
                        width: 55,
                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                color: proteinsColor,
                                value: state.product.proteins100G ?? 0,
                                radius: 20,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                color: carbsColor,
                                value: state.product.carbohydrates100G ?? 0,
                                radius: 20,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                color: fatColor,
                                value: state.product.fat100G ?? 0,
                                radius: 20,
                                showTitle: false,
                              ),
                            ],
                          ),
                          swapAnimationDuration: Duration(seconds: 3),
                          swapAnimationCurve: Curves.bounceIn,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proteins (${(proteinsPercentage * 100).toStringAsFixed(1)}%): ${state.product
                                .proteins100G?.toStringAsFixed(1) ?? ""} ${state.product.proteinsUnit}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: proteinsColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Carbs (${(carbohydratesPercentage * 100).toStringAsFixed(1)}%): ${state.product
                                .carbohydrates100G?.toStringAsFixed(1) ?? ""} ${state.product.carbohydratesUnit}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: carbsColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Fat (${(fatPercentage * 100).toStringAsFixed(1)}%): ${state.product.fat100G
                                ?.toStringAsFixed(1) ?? ""} ${state.product.fatUnit}',
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
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: Text(
                    "Ingredients: ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: state.isVegan! ? Theme
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
                        state.product.ingredientsText != null && state.product.ingredientsText!.isNotEmpty
                            ? state.product.ingredientsText!
                            : 'Ingredients not found'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: state.isVegan! ? Theme
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
                        '${state.product.labels ?? ""}',
                        style:
                        TextStyle(fontSize: 12.sp, color: Colors.green.shade900, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
