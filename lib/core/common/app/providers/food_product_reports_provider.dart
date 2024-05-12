import 'package:flutter/material.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';

class FoodProductReportsProvider extends ChangeNotifier {
  List<FoodProductReport>? _reports;

  List<FoodProductReport>? get reports => _reports;

  set reports(List<FoodProductReport>? reports) {
    if (_reports != reports) {
      _reports = reports;
    }
    Future.delayed(Duration.zero, notifyListeners);
  }
}
