import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  const RestaurantsRepositoryImpl(this._remoteDataSource);
  final RestaurantsRemoteDataSource _remoteDataSource;
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
