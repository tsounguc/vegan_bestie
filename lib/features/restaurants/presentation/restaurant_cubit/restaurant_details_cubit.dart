import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/restaurant_details_entity.dart';
import '../../domain/usecases/get_restaurant_details_usecase.dart';

part 'restaurant_details_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  final GetRestaurantDetailsUseCase _restaurantDetailsUseCase = serviceLocator<GetRestaurantDetailsUseCase>();

  RestaurantDetailsCubit() : super(RestaurantDetailsInitial());

  void searchRestaurantDetails(String? id) async {
    emit(LoadingRestaurantDetails());
    final Either<FetchRestaurantDetailsFailure, RestaurantDetailsEntity> restaurantDetails =
        await _restaurantDetailsUseCase.getRestaurantDetails(id);
    restaurantDetails.fold(
      (restaurantDetailsFailure) => emit(RestaurantDetailsErrorState(error: restaurantDetailsFailure.message)),
      (restaurantDetailsEntity) {
        emit(RestaurantDetailsFoundState(restaurantDetailsEntity: restaurantDetailsEntity));
      },
    );
  }
}
