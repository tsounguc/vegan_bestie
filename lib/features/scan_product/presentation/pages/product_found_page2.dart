import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheveegan/core/constants/strings.dart';
import 'package:sheveegan/core/custom_back_button.dart';
import 'package:sheveegan/core/custom_image_widget.dart';

import '../../../../core/assets/vegan_icon.dart';
import '../../../../core/loading.dart';
import '../fetch_product_cubit/product_fetch_cubit.dart';
import 'components/macronutrient_widget.dart';

class ProductFoundPageTwo extends StatefulWidget {
  const ProductFoundPageTwo({Key? key}) : super(key: key);

  @override
  State<ProductFoundPageTwo> createState() => _ProductFoundPageTwoState();
}

class _ProductFoundPageTwoState extends State<ProductFoundPageTwo> {
  final _scrollController = ScrollController();
  GlobalKey _toolTipKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final dynamic toolTip = _toolTipKey.currentState;

      ProductFetchState state =
          BlocProvider.of<ProductFetchCubit>(context).state;
      if (state is ProductFoundState && state.isVegan == true) {
        await Future.delayed(Duration(milliseconds: 10));
        toolTip.ensureTooltipVisible();
        await Future.delayed(Duration(seconds: 3));
        toolTip.deactivate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            total = state.product.proteins100G! +
                state.product.carbohydrates100G! +
                state.product.fat100G!;
            proteinsPercentage = state.product.proteins100G! / total;
            carbohydratesPercentage = state.product.carbohydrates100G! / total;
            fatPercentage = state.product.fat100G! / total;
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   iconTheme: IconThemeData(color: Colors.black),
            //   title: Text(Strings.appTitle),
            //   centerTitle: true,
            // ),
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.73,
                              // height: 35,
                              child: Text(
                                "${state.product.productName}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            if (state.isVegan!)
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Tooltip(
                                  key: _toolTipKey,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  // verticalOffset: 20,
                                  textAlign: TextAlign.start,
                                  message: Strings.toolTipVeganMessage,
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: Offset(1, 2)),
                                    ],
                                  ),
                                  triggerMode: TooltipTriggerMode.tap,
                                  child: Icon(
                                    VeganIcon.vegan_icon,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  showDuration: Duration(milliseconds: 2750),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Macros",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ]),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.0025),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.0025),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MacroNutrientWidget(
                                title: 'Protein',
                                percentage: proteinsPercentage.isNaN ||
                                        proteinsPercentage.isInfinite ||
                                        proteinsPercentage.isNegative
                                    ? 0
                                    : proteinsPercentage,
                                icon: Image.asset(
                                  'assets/tofu.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.green.shade800,
                                per100G: state.product.proteins100G,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0075,
                              ),
                              MacroNutrientWidget(
                                title: 'Carbs',
                                percentage: carbohydratesPercentage.isNaN ||
                                        carbohydratesPercentage.isInfinite ||
                                        carbohydratesPercentage.isNegative
                                    ? 0
                                    : carbohydratesPercentage,
                                icon: Image.asset(
                                  'assets/bread.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.amberAccent.shade100,
                                per100G: state.product.carbohydrates100G,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.0075,
                              ),
                              MacroNutrientWidget(
                                title: 'Fat',
                                percentage: fatPercentage.isNaN ||
                                        fatPercentage.isInfinite ||
                                        fatPercentage.isNegative
                                    ? 0
                                    : fatPercentage,
                                icon: Image.asset(
                                  'assets/avocado.png',
                                  fit: BoxFit.contain,
                                  height: 10,
                                  width: 10,
                                ),
                                color: Colors.deepPurpleAccent.shade100,
                                per100G: state.product.fat100G,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ingredients",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          radius: Radius.circular(10),
                          thickness: 10,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.0025),
                                child: Text(
                                    state.product.ingredientsText != null &&
                                            state.product.ingredientsText!
                                                .isNotEmpty
                                        ? state.product.ingredientsText!
                                        : 'Ingredients not found'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)
                                    // style: Theme.of(context).textTheme.bodySmall,
                                    ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 1,
                  top: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.width * 0.0,
                  child: CustomImageWidget(
                    imageUrl: state.product.imageFrontUrl,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.01,
                  child: CustomBackButton(),
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
