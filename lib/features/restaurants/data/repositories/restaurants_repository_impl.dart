import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  const RestaurantsRepositoryImpl(this._remoteDataSource);

  final RestaurantsRemoteDataSource _remoteDataSource;

  @override
  ResultVoid updateRestaurant({
    required Restaurant restaurant,
    required dynamic restaurantData,
    required UpdateRestaurantInfoAction action,
  }) async {
    try {
      final result = await _remoteDataSource.updateRestaurant(
        action: action,
        restaurantData: restaurantData,
        restaurant: restaurant,
      );
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultVoid addRestaurant({required Restaurant restaurant}) async {
    try {
      final result = await _remoteDataSource.addRestaurant(
        restaurant: restaurant,
      );
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultVoid submitRestaurant({required RestaurantSubmit restaurantSubmit}) async {
    try {
      final result = await _remoteDataSource.submitRestaurant(restaurantSubmit: restaurantSubmit);
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteRestaurantSubmission({required RestaurantSubmit restaurantSubmit}) async {
    try {
      final result = await _remoteDataSource.deleteRestaurantSubmission(restaurantSubmit: restaurantSubmit);
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<Restaurant>> getRestaurantsNearMe({
    required Position position,
    required double radius,
    String startAfterId = '',
    int paginationSize = 10,
  }) {
    return _remoteDataSource
        .getRestaurantsNearMe(
          position: position,
          radius: radius,
          startAfterId: startAfterId,
          paginationSize: paginationSize,
        )
        .transform(
          StreamTransformer<List<RestaurantModel>, Either<Failure, List<Restaurant>>>.fromHandlers(
            handleData: (restaurants, sink) {
              sink.add(Right(restaurants));
            },
            handleError: (error, stackTrace, sink) {
              debugPrintStack(stackTrace: stackTrace);
              if (error is ServerException) {
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                sink.add(Left(ServerFailure(message: error.toString(), statusCode: 505)));
              }
            },
          ),
        );
  }

  @override
  ResultFuture<UserLocation> getUserLocation() async {
    try {
      final result = await _remoteDataSource.getUserLocation();
      return Right(result);
    } on UserLocationException catch (e) {
      return Left(UserLocationFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MapEntity> getRestaurantsMarkers({required List<Restaurant> restaurants}) async {
    try {
      final result = await _remoteDataSource.getRestaurantsMarkers(restaurants: restaurants);
      return Right(result);
    } on MapException catch (e) {
      return Left(MapFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteRestaurant({required String restaurantId}) async {
    try {
      final result = await _remoteDataSource.deleteRestaurant(
        restaurantId: restaurantId,
      );
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultVoid addRestaurantReview({required RestaurantReview restaurantReview}) async {
    try {
      final result = await _remoteDataSource.addRestaurantReview(restaurantReview);
      return Right(result);
    } on AddRestaurantReviewException catch (e) {
      return Left(AddRestaurantReviewFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteRestaurantReview({required RestaurantReview restaurantReview}) async {
    try {
      final result = await _remoteDataSource.deleteRestaurantReview(restaurantReview);
      return Right(result);
    } on DeleteRestaurantReviewException catch (e) {
      return Left(DeleteRestaurantReviewFailure.fromException(e));
    }
  }

  @override
  ResultVoid editRestaurantReview({required RestaurantReview restaurantReview}) async {
    try {
      final result = await _remoteDataSource.editRestaurantReview(restaurantReview);
      return Right(result);
    } on EditRestaurantReviewException catch (e) {
      return Left(EditRestaurantReviewFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<RestaurantReview>> getRestaurantReviews(String restaurantId) async {
    try {
      final result = await _remoteDataSource.getRestaurantReviews(restaurantId);
      return Right(result);
    } on GetRestaurantReviewsException catch (e) {
      return Left(GetRestaurantReviewsFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveRestaurant({required String restaurantId}) async {
    try {
      final result = await _remoteDataSource.saveRestaurant(restaurantId: restaurantId);
      return Right(result);
    } on SaveRestaurantException catch (e) {
      return Left(SaveRestaurantFailure.fromException(e));
    }
  }

  @override
  ResultVoid unSaveRestaurant({required String restaurantId}) async {
    try {
      final result = await _remoteDataSource.unSaveRestaurant(restaurantId: restaurantId);
      return Right(result);
    } on SaveRestaurantException catch (e) {
      return Left(SaveRestaurantFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Restaurant>> getSavedRestaurants({required List<String> restaurantsIdsList}) async {
    try {
      final result = await _remoteDataSource.getSavedRestaurants(restaurantsIdsList: restaurantsIdsList);
      return Right(result);
    } on SaveRestaurantException catch (e) {
      return Left(SaveRestaurantFailure.fromException(e));
    }
  }

  @override
  ResultVoid submitUpdateSuggestion({required Restaurant restaurant}) {
    // TODO(Submit-Update-Suggestion): implement submitUpdateSuggestion
    throw UnimplementedError();
  }
}

// class RestaurantsRepositoryImpl implements RestaurantsRepository {
//   const RestaurantsRepositoryImpl(this._remoteDataSource);
//
//   final RestaurantsRemoteDataSource _remoteDataSource;
//
//   @override
//   ResultFuture<RestaurantDetails> getRestaurantDetails({
//     required String id,
//   }) async {
//     try {
//       final result = await _remoteDataSource.getRestaurantDetails(id: id);
//       return Right(result);
//     } on RestaurantDetailsException catch (e) {
//       return Left(RestaurantDetailsFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultFuture<List<RestaurantEntity>> getRestaurantsNearMe({
//     required Position position,
//     required double radius,
//   }) async {
//     try {
//       final result = await _remoteDataSource.getRestaurantsNearMe(position: position, radius: radius);
//       return Right(result);
//     } on RestaurantsException catch (e) {
//       return Left(RestaurantsFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultFuture<UserLocation> getUserLocation() async {
//     try {
//       final result = await _remoteDataSource.getUserLocation();
//       return Right(result);
//     } on UserLocationException catch (e) {
//       return Left(UserLocationFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultFuture<MapEntity> getRestaurantsMarkers({
//     required List<RestaurantEntity> restaurants,
//   }) async {
//     try {
//       final result = await _remoteDataSource.getRestaurantsMarkers(
//         restaurants: restaurants,
//       );
//       return Right(result);
//     } on MapException catch (e) {
//       return Left(MapFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultFuture<List<RestaurantDetails>> getSavedRestaurantsList({
//     required List<String> restaurantsList,
//   }) async {
//     try {
//       final result = await _remoteDataSource.getSavedRestaurantsList(
//         restaurantsIdsList: restaurantsList,
//       );
//       return Right(result);
//     } on RestaurantDetailsException catch (e) {
//       return Left(RestaurantDetailsFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultVoid removeRestaurant({required String restaurantId}) async {
//     try {
//       final result = await _remoteDataSource.removeRestaurant(
//         restaurantId: restaurantId,
//       );
//       return Right(result);
//     } on SaveRestaurantException catch (e) {
//       return Left(SaveRestaurantFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultVoid saveRestaurant({required String restaurantId}) async {
//     try {
//       final result = await _remoteDataSource.saveRestaurant(
//         restaurantId: restaurantId,
//       );
//       return Right(result);
//     } on SaveRestaurantException catch (e) {
//       return Left(SaveRestaurantFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultVoid addRestaurantReview({required RestaurantReview restaurantReview}) async {
//     try {
//       final result = await _remoteDataSource.addRestaurantReview(restaurantReview);
//       return Right(result);
//     } on AddRestaurantReviewException catch (e) {
//       return Left(AddRestaurantReviewFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultFuture<List<RestaurantReview>> getRestaurantReviews(String postId) async {
//     try {
//       final result = await _remoteDataSource.getRestaurantReviews(postId);
//       return Right(result);
//     } on GetRestaurantReviewsException catch (e) {
//       return Left(GetRestaurantReviewsFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultVoid deleteRestaurantReview({required RestaurantReview restaurantReview}) async {
//     try {
//       final result = await _remoteDataSource.deleteRestaurantReview(restaurantReview);
//       return Right(result);
//     } on DeleteRestaurantReviewException catch (e) {
//       return Left(DeleteRestaurantReviewFailure.fromException(e));
//     }
//   }
//
//   @override
//   ResultVoid editRestaurantReview({required RestaurantReview restaurantReview}) async {
//     try {
//       final result = await _remoteDataSource.editRestaurantReview(restaurantReview);
//       return Right(result);
//     } on EditRestaurantReviewException catch (e) {
//       return Left(EditRestaurantReviewFailure.fromException(e));
//     }
//   }
// }
