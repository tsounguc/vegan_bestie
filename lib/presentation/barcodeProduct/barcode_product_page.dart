import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/presentation/widgets/error.dart';
import 'package:sheveegan/presentation/widgets/loading.dart';
import 'package:sheveegan/presentation/widgets/product_not_found.dart';

import 'barcodeProductFound/barcode_product_found.dart';

class BarcodeProductPage extends StatelessWidget {
  const BarcodeProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFetchCubit, ProductFetchState>(
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return LoadingPage();
        } else if (state is ProductNotFoundState) {
          return ProductNotFoundPage();
        } else if (state is ProductFetchErrorState) {
          return ErrorPage(error: state.error);
        }
        return BarcodeProductFoundPage();
      },
    );
  }
}
