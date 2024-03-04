import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

abstract class RestaurantsRepository {
  ResultFuture<List<Restaurant>> getRestaurantsNearMe(Position position);

  ResultFuture<RestaurantDetails> getRestaurantDetails(String id);
}
