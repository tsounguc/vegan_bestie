import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/assets/vegan_icon.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/product_provider.dart';

import '../../../../constants/size_config.dart';
import '../../../../constants/strings.dart';

class ProductFoundBodyInfo extends StatelessWidget {
  const ProductFoundBodyInfo({
    Key? key,
    // this.size,
  }) : super(key: key);

  // final Size? size;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductFoundState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * .30,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 60.h,
                  left: 25.w,
                  right: 25.w,
                ),
                height: SizeConfig.screenHeight! * .70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${state.product.product!.productName}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        if ((state.product.product!.ingredientsText != null &&
                                state.product.product!.ingredientsText!.isNotEmpty) &&
                            state.isVegan!)
                          Tooltip(
                            height: 50.h,
                            message: Strings.toolTipVeganMessage,
                            textStyle: TextStyle(fontSize: 14.sp),
                            decoration: BoxDecoration(color: Colors.green),
                            child: Icon(
                              VeganIcon.vegan_icon,
                              color: Theme.of(context).backgroundColor,
                              size: 40.r,
                            ),
                            showDuration: Duration(seconds: 5),
                          ),
                        if ((state.product.product!.ingredientsText != null &&
                                state.product.product!.ingredientsText!.isNotEmpty) &&
                            !state.isVegan!)
                          Tooltip(
                            decoration: BoxDecoration(color: Colors.red),
                            height: 50.h,
                            message: "She ain\'t Vegan 😞 \ncontains ${state.nonVeganIngredientsInProduct!}",
                            textStyle: TextStyle(fontSize: 14.sp),
                            child: Icon(
                              Icons.not_interested_outlined,
                              size: 40.r,
                              color: Colors.red,
                            ),
                            showDuration: Duration(seconds: 5),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Barcode: ${state.product.code}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Text(
                              "Ingredients: ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
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
                                  state.product.product?.ingredientsText != null &&
                                          state.product.product!.ingredientsText!.isNotEmpty
                                      ? state.product.product!.ingredientsText!
                                      : 'Ingredients not found'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Text(
                                  '${state.product.product?.labels ?? ""}',
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
