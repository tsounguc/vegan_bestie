import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories_contracts/restaurants_repository_contract.dart';
import '../data_sources/restaurants_from_remote_data_source.dart';
import '../mapper/restaurant_mapper.dart';
import '../models/yelp_restaurants_model.dart';

class RestaurantsRepositoryYelpImpl implements RestaurantsRepositoryContract {
  RestaurantsFromRemoteDataSourceContract restaurantsFromRemoteDataSourceContract =
      serviceLocator<RestaurantsFromRemoteDataSourceContract>();

  @override
  Future<Either<FetchRestaurantsNearMeFailure, List<RestaurantEntity>>> getRestaurantsNearMe(
      Position position) async {
    try {
      var restaurantModelsList = await restaurantsFromRemoteDataSourceContract.getRestaurantsNearMe(position);

      /// Yelp Implementation. Everything from here can be changed base on which api is used
      RestaurantMapper mapper = RestaurantMapper();
      List<RestaurantEntity> restaurantEntitiesList = [];
      for (int index = 0; index < restaurantModelsList.length; index++) {
        RestaurantEntity restaurantEntity = mapper.mapYelpModelToEntity(restaurantModelsList[index]);
        restaurantEntitiesList.add(restaurantEntity);
      }
      return Right(restaurantEntitiesList);
    } on FetchRestaurantsNearMeException catch (e) {
      return Left(FetchRestaurantsNearMeFailure(message: e.message));
    }
  }
}

class RestaurantsRepositoryGoogleImpl implements RestaurantsRepositoryContract {
  RestaurantsFromRemoteDataSourceContract restaurantsRemoteDataSourceContract =
      serviceLocator<RestaurantsFromRemoteDataSourceContract>();

  @override
  Future<Either<FetchRestaurantsNearMeFailure, List<RestaurantEntity>>> getRestaurantsNearMe(
      Position position) async {
    try {
      var restaurantModelsList = await restaurantsRemoteDataSourceContract.getRestaurantsNearMe(position);

      /// Google Implementation. Everything from here can be changed base on which api is used
      RestaurantMapper mapper = RestaurantMapper();
      List<RestaurantEntity> restaurantEntitiesList = [];
      for (int index = 0; index < restaurantModelsList.length; index++) {
        RestaurantEntity restaurantEntity = mapper.mapGoogleModelToEntity(restaurantModelsList[index], position);
        restaurantEntitiesList.add(restaurantEntity);
      }
      return Right(restaurantEntitiesList);
    } on FetchRestaurantsNearMeException catch (e) {
      return Left(FetchRestaurantsNearMeFailure(message: e.message));
    }
  }
}
