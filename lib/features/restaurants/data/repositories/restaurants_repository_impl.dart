import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories_contracts/restaurants_repository.dart';
import '../data_sources/restaurants_from_remote_data_source.dart';
import '../mapper/restaurant_mapper.dart';
import '../models/yelp_restaurants_model.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  @override
  ResultFuture<RestaurantDetails> getRestaurantDetails({required String id}) {
    // TODO: implement getRestaurantDetails
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Restaurant>> getRestaurantsNearMe({required Position position}) {
    // TODO: implement getRestaurantsNearMe
    throw UnimplementedError();
  }

  // RestaurantsFromRemoteDataSourceContract restaurantsRemoteDataSourceContract =
  //     serviceLocator<RestaurantsFromRemoteDataSourceContract>();
  //
  // @override
  // Future<Either<RestaurantsFailure, List<Restaurant>>> getRestaurantsNearMe(Position position) async {
  //   try {
  //     var restaurantModelsList = await restaurantsRemoteDataSourceContract.getRestaurantsNearMe(position);
  //
  //     /// Google Implementation. Everything from here can be changed base on which api is used
  //     RestaurantMapper mapper = RestaurantMapper();
  //     List<Restaurant> restaurantEntitiesList = [];
  //     for (int index = 0; index < restaurantModelsList.length; index++) {
  //       Restaurant restaurantEntity = mapper.mapGoogleModelToEntity(restaurantModelsList[index], position);
  //       restaurantEntitiesList.add(restaurantEntity);
  //     }
  //     return Right(restaurantEntitiesList);
  //   } on GetRestaurantsException catch (e) {
  //     return Left(RestaurantsFailure(message: e.message));
  //   }
  // }
}
