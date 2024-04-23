import 'package:flutter/material.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

class SavedRestaurantsProvider extends ChangeNotifier {
  List<RestaurantDetails>? _savedRestaurantsList;

  List<RestaurantDetails>? get savedRestaurantsList => _savedRestaurantsList;

  set savedRestaurantsList(List<RestaurantDetails>? savedRestaurantsList) {
    if (_savedRestaurantsList != savedRestaurantsList) {
      _savedRestaurantsList = savedRestaurantsList;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
