import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class AddRestaurant extends UseCaseWithParams<void, Restaurant> {
  const AddRestaurant(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<void> call(Restaurant params) => _repository.addRestaurant(restaurant: params);
}
