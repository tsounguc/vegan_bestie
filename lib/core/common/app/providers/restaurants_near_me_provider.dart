import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/utils/constants.dart';

class RestaurantsNearMeProvider extends ChangeNotifier {
  double _radius = kOneMile * 5.0;

  Position? _currentLocation;

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
