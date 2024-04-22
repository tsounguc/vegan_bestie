import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class ScanResultsPage extends StatelessWidget {
  const ScanResultsPage({super.key});

  static const String id = '/scanResultsPage';

  @override
  Widget build(BuildContext context) {
    Widget page = Container();
    return BlocBuilder<ScanProductCubit, ScanProductState>(
      builder: (context, state) {
        if (state is FetchingProduct) {
          page = const LoadingPage();
        } else if (state is ScanProductError) {
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
