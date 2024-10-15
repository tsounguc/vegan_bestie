import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantsNearMeProvider extends ChangeNotifier {
  double _radius = kOneMileInMeters * 6.0;

  Position? _currentLocation;

  List<String> _categories = [
    'Vegan',
    'Vegan options',
    'Takeout',
    'Dine-in',
    'Delivery',
  ];

  List<String> _selectedCategories = [];

  List<Restaurant>? restaurants;

  bool hasReachedEnd = false;

  GoogleMapController? mapController;

  Set<Marker>? markers;

  double get radius => _radius;

  Position? get currentLocation => _currentLocation;

  List<String> get categories => _categories;

  List<String> get selectedCategories => _selectedCategories;

  void addCategory(String category) {
    _selectedCategories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    _selectedCategories.remove(category);
    notifyListeners();
  }

  set currentLocation(Position? value) {
    _currentLocation = value;
    notifyListeners();
  }

  set radius(double newRadius) {
    if (_radius == newRadius) return;
    _radius = kOneMileInMeters * newRadius;
    notifyListeners();
  }
}
