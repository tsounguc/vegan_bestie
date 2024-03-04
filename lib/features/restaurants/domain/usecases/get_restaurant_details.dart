import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/repositories_contracts/restaurants_repository.dart';

class GetRestaurantDetails extends UseCaseWithParams<RestaurantDetails, GetRestaurantDetailsParams> {
  const GetRestaurantDetails(this._repository);
  final RestaurantsRepository _repository;

  @override
  ResultFuture<RestaurantDetails> call(GetRestaurantDetailsParams params) async =>
      _repository.getRestaurantDetails(params.id);
}

class GetRestaurantDetailsParams extends Equatable {
  const GetRestaurantDetailsParams({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}
