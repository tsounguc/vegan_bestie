part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
}

class RestaurantsInitialState extends RestaurantsState {
  @override
  List<Object> get props => [];
}

class RestaurantsFoundState extends RestaurantsState {
  final List<Restaurant> restaurants;

  RestaurantsFoundState({required this.restaurants});

  @override
  List<Object> get props => [];
}

class RestaurantsLoadingState extends RestaurantsState {
  @override
  List<Object?> get props => [];
}

class RestaurantsErrorState extends RestaurantsState {
  final error;

  RestaurantsErrorState({required this.error});

  @override
  List<Object?> get props => [];
}

class RestaurantsNotFoundState extends RestaurantsState {
  final String message;

  RestaurantsNotFoundState({required this.message});

  @override
  List<Object?> get props => [];
}
