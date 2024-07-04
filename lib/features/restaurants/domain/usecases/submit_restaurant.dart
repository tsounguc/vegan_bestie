import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class SubmitRestaurant extends UseCaseWithParams<void, RestaurantSubmit> {
  const SubmitRestaurant(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<void> call(RestaurantSubmit params) => _repository.submitRestaurant(restaurantSubmit: params);
}
