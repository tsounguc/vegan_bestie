import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/services/restaurants_services/map_service.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../models/map_model.dart';

abstract class MapInfoFromRemoteDataSourceContract {
  Future<MapModel> getRestaurantsModels(List<RestaurantEntity> restaurants, GoogleMapController? controller);
}

class MapInfoFromRemoteDataSourceImpl implements MapInfoFromRemoteDataSourceContract {
  final MapServiceContract mapInfoPluginContract = serviceLocator<MapServiceContract>();

  @override
  Future<MapModel> getRestaurantsModels(
      List<RestaurantEntity> restaurants, GoogleMapController? controller) async {
    try {
      MapModel mapModel = await mapInfoPluginContract.getRestaurantsMarkers(restaurants, controller);
      return mapModel;
    } catch (e) {
      throw const MapException(message: "Failed to fetch restaurants near you");
    }
  }
}
