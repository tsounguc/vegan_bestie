import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

abstract class RestaurantsRepository {
  const RestaurantsRepository();

  ResultFuture<UserLocation> getUserLocation();

  ResultVoid addRestaurant({
    required Restaurant restaurant,
  });

  ResultVoid submitRestaurant({required RestaurantSubmit restaurantSubmit});

  ResultVoid deleteRestaurantSubmission({
    required RestaurantSubmit restaurantSubmit,
  });

  ResultVoid submitUpdateSuggestion({required Restaurant restaurant});

  ResultVoid updateRestaurant({
    required Restaurant restaurant,
    required dynamic restaurantData,
    required UpdateRestaurantInfoAction action,
  });

  ResultVoid saveRestaurant({required String restaurantId});

  ResultVoid unSaveRestaurant({required String restaurantId});

  ResultFuture<List<Restaurant>> getSavedRestaurants({
    required List<String> restaurantsIdsList,
  });

  ResultVoid deleteRestaurant({required String restaurantId});

  ResultStream<List<Restaurant>> getRestaurantsNearMe({
    required Position position,
    required double radius,
    String startAfterId = '',
    int paginationSize = 10,
  });

  ResultVoid addRestaurantReview({
    required RestaurantReview restaurantReview,
  });

  ResultFuture<List<RestaurantReview>> getRestaurantReviews(String restaurantId);

  ResultVoid editRestaurantReview({
    required RestaurantReview restaurantReview,
  });

  ResultVoid deleteRestaurantReview({
    required RestaurantReview restaurantReview,
  });

  ResultFuture<MapEntity> getRestaurantsMarkers({required List<Restaurant> restaurants});
}

// abstract class RestaurantsRepository {
//   ResultFuture<List<RestaurantEntity>> getRestaurantsNearMe({
//     required Position position,
//     required double radius,
//   });
//
//   ResultFuture<RestaurantDetails> getRestaurantDetails({
//     required String id,
//   });
//
//   ResultFuture<UserLocation> getUserLocation();
//
//   ResultFuture<MapEntity> getRestaurantsMarkers({
//     required List<RestaurantEntity> restaurants,
//   });
//
//   ResultFuture<List<RestaurantDetails>> getSavedRestaurantsList({
//     required List<String> restaurantsList,
//   });
//
//   ResultVoid removeRestaurant({required String restaurantId});
//
//   ResultVoid saveRestaurant({required String restaurantId});
//
//   ResultVoid addRestaurantReview({
//     required RestaurantReview restaurantReview,
//   });
//
//   ResultFuture<List<RestaurantReview>> getRestaurantReviews(
//     String postId,
//   );
//
//   ResultVoid deleteRestaurantReview({
//     required RestaurantReview restaurantReview,
//   });
//
//   ResultVoid editRestaurantReview({
//     required RestaurantReview restaurantReview,
//   });
// }
