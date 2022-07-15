import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/presentation/ProductFound/product_found.dart';
import 'package:sheveegan/presentation/productFetchError/product_fetch_error.dart';
import 'package:sheveegan/presentation/productLoading/product_loading.dart';
import 'package:sheveegan/presentation/productNotFound/product_not_found.dart';

class BarcodeProductSearchResultsScreen extends StatelessWidget {
  const BarcodeProductSearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return ProductLoadingPage();
        }
        else if (state is ProductNotFoundState) {
          return ProductNotFoundPage();
        }
        else if (state is ProductFetchErrorState) {
          return ProductFetchErrorPage(error: state.error);
        }
        return ProductFoundPage();
      },
    );
  }
}
