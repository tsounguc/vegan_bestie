import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/presentation/ProductFound/product_found.dart';
import 'package:sheveegan/presentation/productNotFound/product_not_found.dart';

class BarcodeProductSearchResultsScreen extends StatelessWidget {
  const BarcodeProductSearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Searching...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        } else if (state is ProductNotFoundState) {
          return ProductNotFoundPage();
        } else if (state is ProductFetchErrorState) {
          return Column(
            children: [
              Center(
                child: Text('${state.error}'),
              )
            ],
          );
        }
        return ProductFoundPage();
      },
    );
  }
}
