import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/usecases/get_restaurants_near_me_usecase.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final GetRestaurantsNearMeUseCase _getRestaurantsNearMeUseCase = serviceLocator<GetRestaurantsNearMeUseCase>();
  RestaurantsBloc() : super(RestaurantsInitialState()) {
    on<GetRestaurantsEvent>((event, emit) async {
      emit(RestaurantsLoadingState());
      final Either<FetchRestaurantsNearMeFailure, List<RestaurantEntity>> restaurantsResults =
          await _getRestaurantsNearMeUseCase.getRestaurantsNearMe(event.position!);
      restaurantsResults.fold(
        (fetchRestaurantNearMeFailure) => emit(RestaurantsErrorState(error: fetchRestaurantNearMeFailure.message)),
        (restaurants) {
          if (restaurants == null || restaurants.isEmpty) {
            emit(RestaurantsNotFoundState(message: "No restaurant found near you"));
          } else {
            emit(RestaurantsFoundState(restaurants: restaurants));
          }
        },
      );
    });
  }
}
