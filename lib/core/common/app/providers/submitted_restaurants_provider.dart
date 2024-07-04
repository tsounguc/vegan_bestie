import 'package:flutter/material.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';

class SubmittedRestaurantsProvider extends ChangeNotifier {
  List<RestaurantSubmit>? _submittedRestaurants;

  List<RestaurantSubmit>? get submittedRestaurants => _submittedRestaurants;

  set submittedRestaurants(List<RestaurantSubmit>? restaurants) {
    if (_submittedRestaurants != restaurants) {
      _submittedRestaurants = restaurants;
    }
    Future.delayed(Duration.zero, notifyListeners);
  }
}
