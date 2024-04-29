import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class EditRestaurantReview extends UseCaseWithParams<void, RestaurantReview> {
  EditRestaurantReview(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultVoid call(RestaurantReview params) async => _repository.editRestaurantReview(
        restaurantReview: params,
      );
}
