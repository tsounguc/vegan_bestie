import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/restaurant_entity.dart';
import '../repositories_contracts/restaurants_repository_contract.dart';

class GetRestaurantsNearMeUseCase {
  final RestaurantsRepositoryContract _restaurantsRepositoryContract =
      serviceLocator<RestaurantsRepositoryContract>();
  Future<Either<FetchRestaurantsNearMeFailure, List<RestaurantEntity>>> getRestaurantsNearMe(Position position) {
    return _restaurantsRepositoryContract.getRestaurantsNearMe(position);
  }
}
