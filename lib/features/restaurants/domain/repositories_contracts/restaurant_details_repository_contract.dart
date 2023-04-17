import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/restaurant_details_entity.dart';

abstract class RestaurantDetailsRepositoryContract {
  Future<Either<FetchRestaurantDetailsFailure, RestaurantDetailsEntity>> getRestaurantDetail(String? id);
}
