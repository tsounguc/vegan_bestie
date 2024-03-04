import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/map_entity.dart';
import '../entities/restaurant.dart';

abstract class MapRepositoryContract {
  Future<Either<MapFailure, MapEntity>> getRestaurantsMarkers(List<Restaurant> restaurants);
}
