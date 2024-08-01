import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantsNearMeProvider extends ChangeNotifier {
  double _radius = kOneMileInMeters * 3.0;

  Position? _currentLocation;

  List<Restaurant>? restaurants;

  Set<Marker>? markers;

  double get radius => _radius;

  Position? get currentLocation => _currentLocation;

  set currentLocation(Position? value) {
    _currentLocation = value;
    notifyListeners();
  }

  set radius(double newRadius) {
    if (_radius == newRadius) return;
    _radius = newRadius;
    notifyListeners();
  }
}
