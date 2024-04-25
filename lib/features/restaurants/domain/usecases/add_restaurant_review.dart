import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class AddRestaurantReview extends UseCaseWithParams<void, RestaurantReview> {
  AddRestaurantReview(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultVoid call(RestaurantReview params) async => _repository.addRestaurantReview(
        restaurantReview: params,
      );
}
