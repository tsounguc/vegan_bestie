import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

import '../entities/map_entity.dart';

abstract class RestaurantsRepository {
  ResultFuture<List<Restaurant>> getRestaurantsNearMe({required Position position});

  ResultFuture<RestaurantDetails> getRestaurantDetails({required String id});

  ResultFuture<MapEntity> getUserLocation();
}
