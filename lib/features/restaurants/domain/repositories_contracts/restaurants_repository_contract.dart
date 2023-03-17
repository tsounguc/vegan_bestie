import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/restaurant_entity.dart';

abstract class RestaurantsRepositoryContract {
  Future<Either<FetchRestaurantsNearMeFailure, List<RestaurantEntity>>> getRestaurantsNearMe(Position position);
}
