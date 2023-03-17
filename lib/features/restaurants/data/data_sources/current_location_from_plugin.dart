import 'package:geolocator/geolocator.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/services/restaurants_services/current_location_plugin.dart';
import '../models/location_model.dart';

abstract class CurrentLocationFromPluginContract {
  Future<LocationModel> getCurrentLocation();
}

class CurrentLocationFromGeoLocatorPluginImpl implements CurrentLocationFromPluginContract {
  final CurrentLocationPluginContract currentLocationPluginContract =
      serviceLocator<CurrentLocationPluginContract>();
  @override
  Future<LocationModel> getCurrentLocation() async {
    Position position = await currentLocationPluginContract.getCurrentLocation();
    return LocationModel(position: position);
  }
}
