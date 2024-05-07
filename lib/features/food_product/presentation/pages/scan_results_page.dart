import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';

class ScanResultsPage extends StatelessWidget {
  const ScanResultsPage({super.key});

  static const String id = '/scanResultsPage';

  @override
  Widget build(BuildContext context) {
    Widget page = Container();
    return BlocBuilder<FoodProductCubit, FoodProductState>(
      builder: (context, state) {
        if (state is FetchingProduct) {
          page = const LoadingPage();
        } else if (state is FoodProductError) {
          page = ErrorPage(error: state.message);
        } else if (state is ProductNotFound) {
          page = const ProductNotFoundPage();
        } else if (state is ProductFound) {
          page = ProductFoundPage(
            product: state.product,
          );
        }
        return page;
      },
    );
  }
}