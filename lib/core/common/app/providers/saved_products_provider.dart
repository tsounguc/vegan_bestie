import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

class SavedProductsProvider extends ChangeNotifier {
  List<FoodProduct>? _savedProductsList;

  List<FoodProduct>? get savedProductsList => _savedProductsList;

  void initSavedProductList(List<String> savedBarcodesList, BuildContext context) {
    if (savedBarcodesList.isEmpty) {
      _savedProductsList = [];
    } else if (savedBarcodesList.isNotEmpty) {
      // BlocProvider.of<ScanProductCubit>(
      //   context,
      // ).fetchProductsList(savedBarcodesList);
      //
      // final state = BlocProvider.of<ScanProductCubit>(
      //   context,
      // ).state;

      // if (state is SavedProductsListFetched) {
      //   print('init ${state.savedProductsList[1].productName}');
      //   _savedProductsList = state.savedProductsList;
      //   Future.delayed(Duration.zero, notifyListeners);
      // }
    }
  }

  set savedProductsList(List<FoodProduct>? savedProductsList) {
    if (_savedProductsList != savedProductsList) {
      _savedProductsList = savedProductsList;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
