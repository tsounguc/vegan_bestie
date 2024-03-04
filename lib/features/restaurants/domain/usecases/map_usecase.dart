import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../entities/map_entity.dart';
import '../entities/restaurant.dart';
import '../repositories_contracts/map_repository_contract.dart';

class MapUseCase {
  final MapRepositoryContract _mapRepositoryContract = serviceLocator<MapRepositoryContract>();

  Future<Either<MapFailure, MapEntity>> getRestaurantsMarkers(List<Restaurant> restaurants) {
    return _mapRepositoryContract.getRestaurantsMarkers(restaurants);
  }
}
