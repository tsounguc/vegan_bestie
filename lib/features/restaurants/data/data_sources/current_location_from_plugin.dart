import 'package:geolocator/geolocator.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/service_locator.dart';
import '../../../../core/services/restaurants_services/current_location_plugin.dart';
import '../models/location_model.dart';

abstract class CurrentLocationFromPluginContract {
  Future<LocationModel> getCurrentLocation();

  Future<LocationModel> getLastLocation();
}

class CurrentLocationFromGeoLocatorPluginImpl implements CurrentLocationFromPluginContract {
  final CurrentLocationPluginContract currentLocationPluginContract =
      serviceLocator<CurrentLocationPluginContract>();

  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      Position position = await currentLocationPluginContract.getCurrentLocation();
      return LocationModel(position: position);
    } catch (e) {
      throw LocationException(message: "Failed to get current location");
    }
  }

  @override
  Future<LocationModel> getLastLocation() async {
    try {
      Position position = await currentLocationPluginContract.getLastLocation();
      return LocationModel(position: position);
    } catch (e) {
      throw LocationException(message: "Failed to get current location");
    }
  }
}
