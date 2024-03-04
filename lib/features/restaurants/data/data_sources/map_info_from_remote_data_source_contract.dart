import 'package:sheveegan/core/services/restaurants_services/map_service.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/restaurant.dart';
import '../models/map_model.dart';

abstract class MapInfoFromRemoteDataSourceContract {
  Future<MapModel> getRestaurantsModels(List<Restaurant> restaurants);
}

class MapInfoFromRemoteDataSourceImpl implements MapInfoFromRemoteDataSourceContract {
  final MapServiceContract mapInfoPluginContract = serviceLocator<MapServiceContract>();

  @override
  Future<MapModel> getRestaurantsModels(List<Restaurant> restaurants) async {
    try {
      MapModel mapModel = await mapInfoPluginContract.getRestaurantsMarkers(restaurants);
      return mapModel;
    } catch (e) {
      throw const MapException(message: "Failed to fetch restaurants near you");
    }
  }
}
