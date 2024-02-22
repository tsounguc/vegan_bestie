import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/features/scan_product/presentation/fetch_product_cubit/product_fetch_cubit.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';

import '../../../../core/common/screens/product_screens/product_not_found.dart';
import 'product_found_page2.dart';

class ScanResultsPage extends StatelessWidget {
  static const String id = "/scanResultsPage";

  const ScanResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return LoadingPage();
        } else if (state is ProductFetchErrorState) {
          return ErrorPage(error: state.error);
        } else if (state is ProductNotFoundState) {
          return ProductNotFoundPage();
        }
        return ProductFoundPageTwo();
        // return ProductFoundPage();
      },
    );
  }
}
