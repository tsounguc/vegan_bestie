// import 'dart:html';

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/constants/colors.dart';
import 'package:sheveegan/constants/size_config.dart';
import 'package:sheveegan/data/providers/open_food_facts_api_provider.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/presentation/ProductFound/product_found.dart';
import 'package:sheveegan/presentation/productNotFound/product_not_found.dart';
import 'package:sheveegan/presentation/search/search.dart';
import 'package:simple_animations/stateless_animation/custom_animation.dart';
import '../constants/strings.dart';
import '../data/repositoryLayer/repository.dart';
import '../logic/bloc/search_bloc.dart';
import '../logic/cubit/barcode_scanner_cubit.dart';
import 'barcode_product_search_results_screen.dart';

class VeganBestieHome extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MultiBlocListener(
        listeners: [
          BlocListener<BarcodeScannerCubit, BarcodeScannerState>(
            listener: (context, state) {
              if (state is BarcodeFoundState) {
                BlocProvider.of<ProductFetchCubit>(buildContext).fetchProduct(state.barcode);
              } else if (state is ScanningCancelledState) {
                ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
                  content: Text(
                    "${state.message}",
                    style: TextStyle(color: Theme.of(buildContext).snackBarTheme.contentTextStyle!.color),
                  ),
                  duration: Duration(milliseconds: 2000),
                ));
              }
            },
          ),
          BlocListener<ProductFetchCubit, ProductFetchState>(
            listener: (context, state) {
              if (state is ProductLoadingState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (newContext) => BarcodeProductSearchResultsScreen(),
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(buildContext).backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 56.h, right: 16.w, bottom: 8.h, left: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(height: 40.r,) // Todo: place holder for search button/bar
                      IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30.r,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            BlocProvider.of<SearchBloc>(buildContext).add(SearchButtonPressedEvent());
                            Navigator.of(buildContext).push(MaterialPageRoute(builder: (_) => SearchPage()));
                            // final result = await OpenFoodFactsApiProvider().searchProductInfo("blue chips");
                            // print(result.body);
                            // },
                          },
                          ),
                    ],
                  ),
                  SizedBox(
                    height: 105.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.appTitle,
                        style: TextStyle(
                          color: titleTextColorOne,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'cursive',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 135.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Strings.tapToScan,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      CustomAnimation<double>(
                        control: CustomAnimationControl.mirror,
                        tween: Tween(
                          begin: 200.r,
                          end: 185.r,
                        ),
                        duration: Duration(milliseconds: 1000),
                        delay: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        startPosition: 0.0,
                        // animationStatusListener: (status) {
                        //   print('Status update: $status');
                        // },
                        builder: (animationContext, animationChild, value) {
                          return Container(
                            width: value,
                            height: value,
                            color: Colors.transparent,
                            child: animationChild,
                          );
                        },
                        child: ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<BarcodeScannerCubit>(buildContext).scanBarcode();
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(6.0),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                            fixedSize: MaterialStateProperty.all(
                              Size.fromRadius(105.r),
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0.r),
                              child: ImageIcon(
                                AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                                size: 170.0.r,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
