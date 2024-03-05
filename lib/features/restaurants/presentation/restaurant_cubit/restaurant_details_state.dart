part of 'restaurant_details_cubit.dart';

abstract class RestaurantDetailsState extends Equatable {
  const RestaurantDetailsState();
}

class RestaurantDetailsInitial extends RestaurantDetailsState {
  @override
  List<Object?> get props => [];
}

class LoadingRestaurantDetails extends RestaurantDetailsState {
  @override
  List<Object?> get props => [];
}

class RestaurantDetailsFoundState extends RestaurantDetailsState {
  const RestaurantDetailsFoundState({required this.restaurantDetailsEntity});

  final RestaurantDetails? restaurantDetailsEntity;

  @override
  List<Object?> get props => [];
}

class RestaurantDetailsErrorState extends RestaurantDetailsState {
  const RestaurantDetailsErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
