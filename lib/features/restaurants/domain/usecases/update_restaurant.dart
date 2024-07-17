import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/enums/update_restaurant_info.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class UpdateRestaurant extends UseCaseWithParams<void, UpdateRestaurantParams> {
  UpdateRestaurant(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<void> call(UpdateRestaurantParams params) => _repository.updateRestaurant(
        restaurant: params.restaurant,
        restaurantData: params.restaurantData,
        action: params.action,
      );
}

class UpdateRestaurantParams extends Equatable {
  const UpdateRestaurantParams({
    required this.action,
    required this.restaurantData,
    required this.restaurant,
  });

  final UpdateRestaurantInfoAction action;
  final dynamic restaurantData;
  final Restaurant restaurant;

  @override
  List<Object?> get props => [
        action,
        restaurantData,
        restaurant,
      ];
}
