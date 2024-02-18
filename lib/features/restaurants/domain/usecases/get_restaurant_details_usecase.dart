import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../entities/restaurant_details_entity.dart';
import '../repositories_contracts/restaurant_details_repository_contract.dart';

class GetRestaurantDetailsUseCase {
  final RestaurantDetailsRepositoryContract _restaurantsRepositoryContract =
      serviceLocator<RestaurantDetailsRepositoryContract>();

  Future<Either<FetchRestaurantDetailsFailure, RestaurantDetailsEntity>> getRestaurantDetails(String? id) {
    return _restaurantsRepositoryContract.getRestaurantDetail(id);
  }
}
