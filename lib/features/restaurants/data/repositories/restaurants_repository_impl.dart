import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  const RestaurantsRepositoryImpl(this._remoteDataSource);

  final RestaurantsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<RestaurantDetails> getRestaurantDetails({
    required String id,
  }) async {
    try {
      final result = await _remoteDataSource.getRestaurantDetails(id: id);
      return Right(result);
    } on RestaurantDetailsException catch (e) {
      return Left(RestaurantDetailsFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Restaurant>> getRestaurantsNearMe({
    required Position position,
  }) async {
    try {
      final result = await _remoteDataSource.getRestaurantsNearMe(
        position: position,
      );
      return Right(result);
    } on RestaurantsException catch (e) {
      return Left(RestaurantsFailure.fromException(e));
    }
  }

  @override
  ResultFuture<MapEntity> getUserLocation() {
    // TODO: implement getUserLocation
    throw UnimplementedError();
  }
}
