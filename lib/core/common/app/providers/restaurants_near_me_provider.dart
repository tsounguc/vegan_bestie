import 'package:flutter/cupertino.dart';
import 'package:sheveegan/core/utils/constants.dart';

class RestaurantsNearMeProvider extends ChangeNotifier {
  int _selectedDistanceButton = 0;
  double _radius = kOneMile * 3.0;
  double _sliderValue = 3;

  int get selectedDistanceButton => _selectedDistanceButton;

  double get radius => _radius;

  double get sliderValue => _sliderValue;

  set sliderValue(double value) {
    if (_sliderValue == value) return;
    _sliderValue = value;
    notifyListeners();
  }

  set radius(double newRadius) {
    if (_radius == newRadius) return;
    _radius = newRadius;
    notifyListeners();
  }

  void changeSelectedButton(int index) {
    if (_selectedDistanceButton == index) return;
    _selectedDistanceButton = index;
    notifyListeners();
  }
}
