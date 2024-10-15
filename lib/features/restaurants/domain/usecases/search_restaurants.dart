import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class SearchRestaurants extends UseCaseWithParams<List<Restaurant>, String> {
  const SearchRestaurants(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<List<Restaurant>> call(String params) => _repository.searchRestaurants(params);
}
