import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

abstract class RestaurantsRepository {
  ResultFuture<List<RestaurantEntity>> getRestaurantsNearMe({
    required Position position,
    required double radius,
  });

  ResultFuture<RestaurantDetails> getRestaurantDetails({
    required String id,
  });

  ResultFuture<UserLocation> getUserLocation();

  ResultFuture<MapEntity> getRestaurantsMarkers({
    required List<RestaurantEntity> restaurants,
  });

  ResultFuture<List<RestaurantDetails>> getSavedRestaurantsList({
    required List<String> restaurantsList,
  });

  ResultVoid removeRestaurant({required String restaurantId});

  ResultVoid saveRestaurant({required String restaurantId});

  ResultVoid addRestaurantReview({
    required RestaurantReview restaurantReview,
  });

  ResultFuture<List<RestaurantReview>> getRestaurantReviews(
    String postId,
  );

  ResultVoid deleteRestaurantReview({
    required RestaurantReview restaurantReview,
  });

  ResultVoid editRestaurantReview({
    required RestaurantReview restaurantReview,
  });
}
