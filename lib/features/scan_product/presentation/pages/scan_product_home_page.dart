import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_results_page.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/size_config.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/vegan_bestie_logo_widget.dart';
import '../../../../themes/app_theme.dart';
import '../../../search/presentation/search_bloc/search_bloc.dart';
import '../barcode_scanner_cubit/barcode_scanner_cubit.dart';
import '../fetch_product_cubit/product_fetch_cubit.dart';

class ScanProductHomePage extends StatelessWidget {
  static const String id = "/scanProductHomePage";

  const ScanProductHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BarcodeScannerCubit, BarcodeScannerState>(
          listener: (context, state) {
            if (state is BarcodeFoundState) {
              BlocProvider.of<ProductFetchCubit>(buildContext).fetchProduct(state.barcode);
            } else if (state is ScanningCanceledState) {
              debugPrint("font families fallback ${Theme.of(context).textTheme.displaySmall?.fontFamilyFallback}");
              ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
                content: Text(
                  "${state.message}",
                  style: TextStyle(color: Theme.of(buildContext).snackBarTheme.contentTextStyle?.color),
                ),
                duration: Duration(milliseconds: 2000),
              ));
            }
          },
        ),
        BlocListener<ProductFetchCubit, ProductFetchState>(
          listener: (context, state) {
            if (state is ProductLoadingState) {
              Navigator.of(context).pushNamed(ScanResultsPage.id);
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 56.h, right: 16.w, bottom: 8.h, left: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Todo: Implement search button/bar
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     // SizedBox(height: 40.r,)
              //     IconButton(
              //       icon: Icon(
              //         Icons.search,
              //         size: 30.r,
              //         color: Colors.white,
              //       ),
              //       onPressed: () {
              //         BlocProvider.of<SearchBloc>(buildContext).searchTextController.clear();
              //         BlocProvider.of<SearchBloc>(buildContext).add(SearchButtonPressedEvent());
              //         Navigator.of(buildContext).push(MaterialPageRoute(builder: (_) => SearchPage()));
              //       },
              //     ),
              //   ],
              // ),
              SizedBox(
                // height: 100 - toolbarHeight,
                height: MediaQuery.of(buildContext).size.height * 0.06,
              ),
              VeganBestieLogoWidget(size: 45),
              SizedBox(
                // height: 100,
                height: MediaQuery.of(buildContext).size.height * 0.15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    Strings.tapToScan,
                    style:
                        Theme.of(buildContext).textTheme.titleMedium?.copyWith(color: AppTheme.lightPrimaryColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(buildContext).size.height * 0.02,
                  ),
                  CustomAnimationBuilder<double>(
                    control: Control.mirror,
                    tween: Tween(
                      begin: MediaQuery.of(buildContext).size.width * 0.55,
                      end: MediaQuery.of(buildContext).size.width * 0.53,
                      // begin: 200.r,
                      // end: 185.r,
                    ),
                    duration: Duration(milliseconds: 1000),
                    delay: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    startPosition: 0.0,
                    // animationStatusListener: (status) {
                    //   print('Status update: $status');
                    // },
                    builder: (animationContext, value, animationChild) {
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
                        fixedSize: MaterialStateProperty.all(Size.fromRadius(105.r)),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(CircleBorder()),
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
    );
  }
}
