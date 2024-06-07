import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetRestaurantsMarkers extends UseCaseWithParams<MapEntity, GetRestaurantsMarkersParams> {
  const GetRestaurantsMarkers(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<MapEntity> call(
    GetRestaurantsMarkersParams params,
  ) async =>
      _repository.getRestaurantsMarkers(restaurants: params.restaurants);
}

class GetRestaurantsMarkersParams extends Equatable {
  const GetRestaurantsMarkersParams({required this.restaurants});

  GetRestaurantsMarkersParams.empty() : this(restaurants: []);

  final List<RestaurantEntity> restaurants;

  @override
  List<Object?> get props => [restaurants];
}
