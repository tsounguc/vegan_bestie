import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ProductImageComponent extends StatelessWidget {
  const ProductImageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // final productScanResults = useProvider(productProvider.state);

    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is ProductFound) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (state.product.imageFrontUrl.isEmpty)
                    Container(
                      height: 213.r,
                      width: 187.r,
                      decoration: BoxDecoration(
                        color: state.isVegan ? Theme.of(context).colorScheme.background : Colors.red.shade900,
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(5, 7.5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: state.isVegan ? Colors.green.shade50 : Colors.red.shade50,
                        size: 175.r,
                      ),
                    )
                  else
                    Container(
                      height: 213.r,
                      width: 187.r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.25),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(5, 7),
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: CachedNetworkImage(
                          height: 213.r,
                          width: 187.r,
                          fit: BoxFit.cover,
                          imageUrl: state.product.imageFrontUrl,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
