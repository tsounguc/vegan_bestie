import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/constants/size_config.dart';

import '../../../../core/assets/vegan_icon.dart';
import '../../../../core/constants/strings.dart';
import '../search_bloc/search_bloc.dart';

class SearchProductDetail extends StatelessWidget {
  const SearchProductDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchProductDetailState) {
          return new WillPopScope(
            onWillPop: () async {
              BlocProvider.of<SearchBloc>(context).add(SearchDetailBackButtonPressedEvent());
              // Navigator.of(context).pop();
              return true;
            },
            child: Container(
              decoration: state.selectedProduct!.imageFrontUrl != null &&
                      state.selectedProduct!.imageFrontUrl!.isNotEmpty
                  ? BoxDecoration(
                      color: state.isVegan! ? Theme.of(context).backgroundColor : Colors.red,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.saturation),
                          image: CachedNetworkImageProvider(state.selectedProduct!.imageFrontUrl!)),
                    )
                  : BoxDecoration(
                      color: state.isVegan! ? Theme.of(context).backgroundColor : Colors.red,
                    ),
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        BlocProvider.of<SearchBloc>(context).add(SearchDetailBackButtonPressedEvent());
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(
                      Strings.appTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 31.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                    // actions: [
                    //   PopupMenuButton(
                    //     icon: Icon(
                    //       Icons.more_vert,
                    //       // size: 25,
                    //       color: Colors.white,
                    //     ),
                    //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    //       PopupMenuItem<String>(
                    //         value: 'Edit Product',
                    //         child: Row(
                    //           children: [
                    //             Expanded(
                    //               child: Text("Edit Product"),
                    //             ),
                    //             Icon(Icons.edit),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //     onSelected: (selectedValue) {
                    //       // if (selectedValue == 'Edit Product') {
                    //       //   Route route = MaterialPageRoute(
                    //       //       builder: (context) =>
                    //       //           AddProduct(title: "Edit Product"));
                    //       //   Navigator.push(context, route);
                    //       // }
                    //     },
                    //   )
                    // ],
                  ),
                  backgroundColor: state.selectedProduct!.imageFrontUrl != null
                      ? Colors.transparent
                      : state.isVegan!
                          ? Theme.of(context).backgroundColor
                          : Colors.red,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: Column(
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
                                                state.selectedProduct!.productName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            if ((state.selectedProduct!.ingredientsText != null &&
                                                    state.selectedProduct!.ingredientsText!.isNotEmpty) &&
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
                                              ),
                                            if ((state.selectedProduct!.ingredientsText != null &&
                                                    state.selectedProduct!.ingredientsText!.isNotEmpty) &&
                                                !state.isVegan!)
                                              Tooltip(
                                                decoration: BoxDecoration(color: Colors.red),
                                                height: 50.h,
                                                message: Strings.toolTipNonVeganMessage +
                                                    ' ' +
                                                    state.nonVeganIngredientsInProduct!,
                                                textStyle: TextStyle(fontSize: 14.sp),
                                                child: Icon(
                                                  Icons.not_interested_outlined,
                                                  size: 40.r,
                                                  color: Colors.red,
                                                ),
                                                showDuration: Duration(seconds: 5),
                                              )
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
                                                    "Barcode: ${state.selectedProduct?.code}",
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
                                                      state.selectedProduct?.ingredientsText != null &&
                                                              state.selectedProduct!.ingredientsText!.isNotEmpty
                                                          ? state.selectedProduct!.ingredientsText!
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
                                                      "${state.selectedProduct?.labels ?? ''}",
                                                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50.h, left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      state.selectedProduct!.imageFrontUrl == null
                                          ? Container(
                                              height: 213.r,
                                              width: 187.r,
                                              decoration: BoxDecoration(
                                                  color: state.isVegan!
                                                      ? Theme.of(context).backgroundColor
                                                      : Colors.red,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(35.r),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black38.withOpacity(0.10),
                                                      spreadRadius: 2,
                                                      blurRadius: 7,
                                                      offset: Offset(5, 7),
                                                    )
                                                  ]),
                                              child: Icon(
                                                Icons.image_outlined,
                                                color: state.isVegan! ? Colors.green.shade50 : Colors.red.shade50,
                                                size: 175.r,
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(35.r),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black38.withOpacity(0.25),
                                                      spreadRadius: 2,
                                                      blurRadius: 7,
                                                      offset: Offset(5, 7),
                                                    )
                                                  ]),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(35),
                                                child: CachedNetworkImage(
                                                  height: 213.r,
                                                  width: 187.r,
                                                  fit: BoxFit.fill,
                                                  imageUrl: state.selectedProduct!.imageFrontUrl!,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

// Future<bool> backButtonPressed(BuildContext context) async {
//   BlocProvider.of<SearchBloc>(context).add(SearchDetailBackButtonPressedEvent());
//   Navigator.of(context).pop();
//   return true;
// }
}
