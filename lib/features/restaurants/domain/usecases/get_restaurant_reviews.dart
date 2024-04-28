import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetRestaurantReviews extends UseCaseWithParams<List<RestaurantReview>, String> {
  GetRestaurantReviews(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<List<RestaurantReview>> call(String params) async => _repository.getRestaurantReviews(
        params,
      );
}
