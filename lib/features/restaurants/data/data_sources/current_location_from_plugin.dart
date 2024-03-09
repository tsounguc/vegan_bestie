import 'package:geolocator/geolocator.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/restaurants_services/location_plugin.dart';
import '../models/user_location_model.dart';

abstract class CurrentLocationFromPluginContract {
  Future<UserLocationModel> getCurrentLocation();

  Future<UserLocationModel> getLastLocation();
}

class CurrentLocationFromGeoLocatorPluginImpl implements CurrentLocationFromPluginContract {
  final CurrentLocationPluginContract currentLocationPluginContract =
      serviceLocator<CurrentLocationPluginContract>();

  @override
  Future<UserLocationModel> getCurrentLocation() async {
    try {
      Position position = await currentLocationPluginContract.getCurrentLocation();
      return UserLocationModel(position: position);
    } catch (e) {
      throw UserLocationException(message: "Failed to get current location");
    }
  }

  @override
  Future<UserLocationModel> getLastLocation() async {
    try {
      Position position = await currentLocationPluginContract.getLastLocation();
      return UserLocationModel(position: position);
    } catch (e) {
      throw UserLocationException(message: "Failed to get current location");
    }
  }
}
