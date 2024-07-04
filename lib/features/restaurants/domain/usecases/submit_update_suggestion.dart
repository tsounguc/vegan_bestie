import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class SubmitUpdateSuggestion extends UseCaseWithParams<void, Restaurant> {
  const SubmitUpdateSuggestion(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultVoid call(Restaurant params) => _repository.submitUpdateSuggestion(restaurant: params);
}
