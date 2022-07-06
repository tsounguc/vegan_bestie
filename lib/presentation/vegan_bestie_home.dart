// import 'dart:html';

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/constants/colors.dart';
import 'package:sheveegan/constants/size_config.dart';
import 'package:simple_animations/stateless_animation/custom_animation.dart';
import 'package:sizer/sizer.dart';
import '../constants/strings.dart';
import '../logic/cubit/barcode_scanner_cubit.dart';

class VeganBestieHome extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BarcodeScannerCubit, BarcodeScannerState>(
          listener: (context, state) {
            if (state is BarcodeFoundState) {
              ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
                content: Text(
                  "${state.barcode}",
                  style: TextStyle(color: Theme.of(buildContext).snackBarTheme.contentTextStyle!.color),
                ),
                duration: Duration(milliseconds: 3000),
              ));
            } else if (state is ScanningCancelled) {
              ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
                content: Text(
                  "${state.message}",
                  style: TextStyle(color: Theme.of(buildContext).snackBarTheme.contentTextStyle!.color),
                ),
                duration: Duration(milliseconds: 2000),
              ));
            }
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Theme.of(buildContext).backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 5.0.h, right: 5.0.w, bottom: 5.0.h, left: 5.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: SizerUtil.deviceType == DeviceType.mobile ? 10.0.w : 7.0.w,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.homeScreenTitle,
                      style: TextStyle(
                        color: titleTextColorOne,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
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
                      height: 3.0.h,
                    ),
                    CustomAnimation<double>(
                      control: CustomAnimationControl.mirror,
                      tween: SizerUtil.deviceType == DeviceType.mobile ? Tween(
                        begin: 52.w,
                        end: 50.w,
                      ): Tween(begin: 50.w, end: 48.w),
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
                          elevation: MaterialStateProperty.all(2.0.w),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          fixedSize: MaterialStateProperty.all(
                            Size.fromRadius(27.w),
                          ),
                          alignment: FractionalOffset(-5.0.w, 5.0.h),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                        ),
                        child: Center(
                          child: ImageIcon(
                            AssetImage('assets/logo/VeganBestie_NoBackground_Fixed2.png'),
                            size: SizerUtil.deviceType == DeviceType.mobile ? 50.0.w : 42.0.w,
                            color: Colors.blueGrey.shade900,
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
      ),
    );
  }

  startBarcodeScanner({bool shouldSnapImage = false}) async {
    // BlocProvider.of<BarcodeScannerCubit>(context).scanBarcode();

    // Repository _repository = Repository();
    //
    // _repository.fetchProduct("0889392010145");
  }
}
