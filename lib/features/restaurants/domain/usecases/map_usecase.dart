import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/map_entity.dart';
import '../entities/restaurant_entity.dart';
import '../repositories_contracts/map_repository_contract.dart';

class MapUseCase {
  final MapRepositoryContract _mapRepositoryContract = serviceLocator<MapRepositoryContract>();

  Future<Either<MapFailure, MapEntity>> getRestaurantsMarkers(
      List<RestaurantEntity> restaurants, GoogleMapController? controller) {
    return _mapRepositoryContract.getRestaurantsMarkers(restaurants, controller);
  }
}
