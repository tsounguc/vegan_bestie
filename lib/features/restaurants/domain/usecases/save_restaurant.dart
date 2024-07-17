import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class SaveRestaurant extends UseCaseWithParams<void, String> {
  SaveRestaurant(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultVoid call(String params) => _repository.saveRestaurant(restaurantId: params);
}
