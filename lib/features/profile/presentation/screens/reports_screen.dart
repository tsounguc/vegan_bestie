import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/food_product_reports_provider.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/firebase_constants.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_report_model.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static const id = 'reportsScreen';

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return StreamBuilder<List<FoodProductReport>>(
      stream: serviceLocator<FirebaseFirestore>()
          .collection(FirebaseConstants.foodProductReportCollection)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (event) => FoodProductReportModel.fromMap(event.data()),
                )
                .toList(),
          ),
      builder: (context, snapshot) {
        final reports = context.reportsProvider.reports = snapshot.data ?? <FoodProductReportModel>[];
        return BlocListener<FoodProductCubit, FoodProductState>(
          listener: (context, state) {
            if (state is ProductFound) {
              Navigator.of(context).pushNamed(
                ProductFoundPage.id,
                arguments: state.product,
              );
            }
          },
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.white,
              leading: CustomBackButton(
                color: context.theme.iconTheme.color!,
              ),
              title: const Text(
                'Reports',
              ),
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: reports.length,
                    itemBuilder: (BuildContext context, int index) {
                      final report = reports[index];
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<FoodProductCubit>(context).fetchProduct(
                            barcode: report.barcode,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 25,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade700),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Barcode: ${report.barcode}',
                                    style: TextStyle(
                                      // color: Colors.grey.shade800,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<FoodProductCubit>(
                                        context,
                                      ).deleteReports(report);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'From User: ${report.userName}',
                                style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Issues: ',
                                style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (report.incorrectImage)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    'Incorrect Image',
                                    style: TextStyle(
                                      // color: Colors.grey.shade800,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              if (report.incorrectProductName)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Incorrect Product Name',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Suggestion: ${report.productNameSuggestion}',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (report.incorrectMacros)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Incorrect Macros',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Suggestion: ${report.macrosSuggestion}',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (report.incorrectIngredients)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Incorrect Ingredients',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Suggestion: ${report.ingredientsSuggestion}',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (report.incorrectLabel)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Incorrect Label',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Suggestion: ${report.labelSuggestion}',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (report.isWrongProduct)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wrong Product',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'Suggestion: ${report.productDescription}',
                                        style: TextStyle(
                                          // color: Colors.grey.shade800,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (report.doesNotExist)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    "Doesn't Not Exist",
                                    style: TextStyle(
                                      // color: Colors.grey.shade800,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              Text(
                                'Comment: ${report.comment}',
                                style: TextStyle(
                                  // color: Colors.grey.shade800,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
