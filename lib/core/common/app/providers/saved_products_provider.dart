import 'package:flutter/material.dart';
import 'package:sheveegan/features/scan_product/domain/entities/food_product.dart';

class SavedProductsProvider extends ChangeNotifier {
  List<FoodProduct>? _savedProductsList;

  List<FoodProduct>? get savedProductsList => _savedProductsList;

  set savedProductsList(List<FoodProduct>? savedProductsList) {
    if (_savedProductsList != savedProductsList) {
      _savedProductsList = savedProductsList;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
