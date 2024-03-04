import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/restaurant_details.dart';
import '../../domain/repositories_contracts/restaurant_details_repository_contract.dart';
import '../data_sources/restaurant_details_from_remote_data_source.dart';
import '../mapper/restaurant_details_mapper.dart';
import '../models/google_restaurant_details_model.dart';
import '../models/yelp_restaurant_details_model.dart';

// class RestaurantDetailsRepositoryYelpImpl implements RestaurantDetailsRepositoryContract {
//   RestaurantDetailsFromRemoteDataSourceContract restaurantDetailsFromRemoteDataSourceContract =
//       serviceLocator<RestaurantDetailsFromRemoteDataSourceContract>();
//
//   @override
//   Future<Either<FetchRestaurantDetailsFailure, RestaurantDetailsEntity>> getRestaurantDetail(String? id) async {
//     try {
//       YelpRestaurantDetailsModel restaurantModel =
//           await restaurantDetailsFromRemoteDataSourceContract.getRestaurantDetails(id);
//       RestaurantDetailsMapper mapper = RestaurantDetailsMapper();
//       RestaurantDetailsEntity? restaurantDetailsEntity = mapper.mapYelpModelToEntity(restaurantModel);
//       return Right(restaurantDetailsEntity!);
//     } on FetchRestaurantDetailsException catch (e) {
//       return Left(FetchRestaurantDetailsFailure(message: e.message));
//     }
//   }
// }

class RestaurantDetailsRepositoryGoogleImpl implements RestaurantDetailsRepositoryContract {
  RestaurantDetailsFromRemoteDataSourceContract restaurantDetailsFromRemoteDataSourceContract =
      serviceLocator<RestaurantDetailsFromRemoteDataSourceContract>();

  @override
  Future<Either<FetchRestaurantDetailsFailure, RestaurantDetails>> getRestaurantDetail(String? id) async {
    try {
      GoogleRestaurantDetailsModel restaurantModel =
          await restaurantDetailsFromRemoteDataSourceContract.getRestaurantDetails(id);
      RestaurantDetailsMapper mapper = RestaurantDetailsMapper();
      RestaurantDetails restaurantDetailsEntity = mapper.mapGoogleModelToEntity(restaurantModel);
      return Right(restaurantDetailsEntity);
    } on GetRestaurantDetailsException catch (e) {
      return Left(FetchRestaurantDetailsFailure(message: e.message));
    }
  }
}
