import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class RemoveRestaurant extends UseCaseWithParams<void, String> {
  const RemoveRestaurant(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<void> call(String params) async => _repository.removeRestaurant(
        restaurantId: params,
      );
}
