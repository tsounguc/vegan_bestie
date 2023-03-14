import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/strings.dart';
import '../fetch_product_cubit/product_fetch_cubit.dart';
import 'components/product_found_body.dart';

class ProductFoundPage extends StatelessWidget {
  static const String id = "/productFoundPage";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return CircularProgressIndicator();
        } else if (state is ProductFoundState) {
          debugPrint("Product Found");
          // debugPrint(state.product.product!.productName);
          return Container(
            decoration: state.product.imageFrontUrl != null && state.product.imageFrontUrl!.isNotEmpty
                ? BoxDecoration(
                    color: state.isVegan! ? Theme.of(context).colorScheme.background : Colors.red,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.saturation),
                      image: CachedNetworkImageProvider(state.product.imageFrontUrl!),
                    ),
                  )
                : BoxDecoration(
                    color: state.isVegan! ? Theme.of(context).colorScheme.background : Colors.red,
                  ),
            child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
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
                backgroundColor: Colors.transparent,
                // backgroundColor: state.product.imageFrontUrl != null
                //     ? Colors.transparent
                //     : state.isVegan!
                //         ? Theme.of(context).colorScheme.background
                //         : Colors.red,
                body: Container(child: ProductFoundBody()),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
