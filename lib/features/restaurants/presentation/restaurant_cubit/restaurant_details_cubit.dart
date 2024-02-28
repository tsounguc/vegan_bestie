import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details_entity.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details_usecase.dart';

part 'restaurant_details_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  RestaurantDetailsCubit() : super(RestaurantDetailsInitial());
  final GetRestaurantDetailsUseCase _restaurantDetailsUseCase = serviceLocator<GetRestaurantDetailsUseCase>();

  Future<void> searchRestaurantDetails(String? id) async {
    emit(LoadingRestaurantDetails());
    final restaurantDetails = await _restaurantDetailsUseCase.getRestaurantDetails(id);
    restaurantDetails.fold(
      (restaurantDetailsFailure) => emit(
        RestaurantDetailsErrorState(
          message: restaurantDetailsFailure.message,
        ),
      ),
      (restaurantDetailsEntity) {
        emit(
          RestaurantDetailsFoundState(
            restaurantDetailsEntity: restaurantDetailsEntity,
          ),
        );
      },
    );
  }
}
