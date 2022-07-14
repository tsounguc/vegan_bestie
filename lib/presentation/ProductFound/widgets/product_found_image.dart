import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/product_provider.dart';

class ProductFoundImage extends StatelessWidget {
  const ProductFoundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productScanResults = useProvider(productProvider.state);

    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductFoundState) {
          print("Url:  ${state.product.product!.imageFrontUrl}");
          return Padding(
            padding: EdgeInsets.only(top: 50.h, right: 135.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    state.product.product!.imageFrontUrl == null
                        ? Container(
                            height: 213.r,
                            width: 187.r,
                            decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
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
                              color:
                                  // context.read(productProvider).sheVegan
                                  //     ?
                                  Colors.green.shade50
                              // : Colors.red.shade50
                              ,
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
                                imageUrl:
                                    state.product.product!.imageFrontUrl!,
                              ),
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
