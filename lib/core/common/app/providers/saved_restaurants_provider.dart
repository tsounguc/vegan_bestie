import 'package:flutter/material.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class SavedRestaurantsProvider extends ChangeNotifier {
  List<Restaurant>? _savedRestaurantsList;

  List<Restaurant>? get savedRestaurantsList => _savedRestaurantsList;

  set savedRestaurantsList(List<Restaurant>? savedRestaurantsList) {
    if (_savedRestaurantsList != savedRestaurantsList) {
      _savedRestaurantsList = savedRestaurantsList;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
