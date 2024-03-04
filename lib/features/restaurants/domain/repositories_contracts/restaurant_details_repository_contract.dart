import 'package:dartz/dartz.dart';
import '../../../../core/failures_successes/failures.dart';
import '../entities/restaurant_details.dart';

abstract class RestaurantDetailsRepositoryContract {
  Future<Either<FetchRestaurantDetailsFailure, RestaurantDetails>> getRestaurantDetail(String? id);
}
