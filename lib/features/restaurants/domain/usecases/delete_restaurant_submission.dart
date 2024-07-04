import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class DeleteRestaurantSubmission extends UseCaseWithParams<void, RestaurantSubmit> {
  DeleteRestaurantSubmission(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultVoid call(RestaurantSubmit params) => _repository.deleteRestaurantSubmission(restaurantSubmit: params);
}
