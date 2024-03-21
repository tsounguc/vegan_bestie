import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/custom_image_widget.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/components/macronutrient_widget.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductFoundPageTwo extends StatefulWidget {
  const ProductFoundPageTwo({super.key});

  @override
  State<ProductFoundPageTwo> createState() => _ProductFoundPageTwoState();
}

class _ProductFoundPageTwoState extends State<ProductFoundPageTwo> {
  final _scrollController = ScrollController();
  final GlobalKey _toolTipKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final dynamic toolTip = _toolTipKey.currentState;

      final state = BlocProvider.of<ScanProductCubit>(context).state;
      if (state is ProductFound && state.product.ingredients.isNotEmpty) {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        toolTip.ensureTooltipVisible();
        await Future<void>.delayed(const Duration(seconds: 3));
        toolTip.deactivate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is ProductFound) {
          final proteinsAmount = state.product.proteins100G;
          final carbsAmount = state.product.carbohydrates100G;
          final fatAmount = state.product.fat100G;
          final total = proteinsAmount + carbsAmount + fatAmount;
          var proteinsPct = proteinsAmount / total * 100;
          if (proteinsPct.isNaN || proteinsPct.isInfinite || proteinsPct.isNegative) {
            proteinsPct = 0;
          }
          var carbsPct = carbsAmount / total * 100;
          if (carbsPct.isNaN || carbsPct.isInfinite || carbsPct.isNegative) {
            carbsPct = 0;
          }
          var fatPct = fatAmount / total * 100;
          if (fatPct.isNaN || fatPct.isInfinite || fatPct.isNegative) {
            fatPct = 0;
          }

          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height * 0.53,
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.77,
                              height: width * 0.08,
                              child: Text(
                                state.product.productName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (state.product.ingredients.isNotEmpty)
                              Container(
                                height: width * 0.09,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Tooltip(
                                  key: _toolTipKey,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 16,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  // verticalOffset: 20,
                                  textAlign: TextAlign.start,
                                  message: state.isVegan == true
                                      ? Strings.toolTipVeganMessage
                                      : state.isVegan == false
                                          ? '${Strings.toolTipNonVeganMessage} '
                                              '${state.nonVeganIngredients}'
                                          : null,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: BoxDecoration(
                                    color: state.isVegan == true ? Colors.green : Colors.blue,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 1,
                                        offset: Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  triggerMode: TooltipTriggerMode.tap,
                                  showDuration: const Duration(
                                    milliseconds: 2750,
                                  ),
                                  child: state.isVegan == true
                                      ? const Icon(
                                          VeganIcon.vegan_icon,
                                          color: Colors.green,
                                          size: 22,
                                        )
                                      : Center(
                                          child: Icon(
                                            Icons.info_outlined,
                                            color: Colors.blueGrey.shade600,
                                          ),
                                        ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.macrosText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.0025,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: height * 0.0025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MacroNutrientWidget(
                                title: Strings.proteinText,
                                percentage: proteinsPct,
                                icon: Image.asset(
                                  'assets/tofu.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.green.shade800,
                                value: state.product.proteinsValue,
                              ),
                              SizedBox(
                                height: height * 0.0075,
                              ),
                              MacroNutrientWidget(
                                title: Strings.carbsText,
                                percentage: carbsPct,
                                icon: Image.asset(
                                  'assets/bread.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.amberAccent.shade100,
                                value: state.product.carbohydratesValue,
                              ),
                              SizedBox(
                                height: height * 0.0075,
                              ),
                              MacroNutrientWidget(
                                title: Strings.fatText,
                                percentage: fatPct,
                                icon: Image.asset(
                                  'assets/avocado.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.deepPurpleAccent.shade100,
                                value: state.product.fatValue,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.ingredientsText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          radius: const Radius.circular(10),
                          thickness: 10,
                          child: SizedBox(
                            height: height * 0.125,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: height * 0.0025,
                                ),
                                child: Text(
                                  state.product.ingredientsText.isNotEmpty
                                      ? state.product.ingredientsText
                                      : Strings.ingredientsNotFoundText,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.of(context)
                        //             .pushNamed(ReportIssuePage.id);
                        //       },
                        //       child: Text(
                        //         Strings.reportIssueText,
                        //         style: TextStyle(
                        //             color: Colors.black,
                        //             fontSize: 12.sp,
                        //             fontWeight: FontWeight.normal,
                        //             decoration: TextDecoration.underline,
                        //             decorationThickness: 2),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: width * 1,
                  top: height * 0.0,
                  left: width * 0.0,
                  child: CustomImageWidget(
                    imageUrl: state.product.imageFrontUrl,
                    height: height * 0.45,
                  ),
                ),
                Positioned(
                  top: height * 0.05,
                  left: width * 0.01,
                  child: const CustomBackButton(),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
