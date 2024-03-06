part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
  @override
  List<Object> get props => [];
}

class RestaurantsInitial extends RestaurantsState {
  const RestaurantsInitial();
}

class LoadingRestaurants extends RestaurantsState {
  const LoadingRestaurants();
}

class LoadingRestaurantDetails extends RestaurantsState {
  const LoadingRestaurantDetails();
}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantDetailsLoaded extends RestaurantsState {
  const RestaurantDetailsLoaded({required this.restaurantDetails});
  final RestaurantDetails restaurantDetails;

  @override
  List<Object> get props => [restaurantDetails];
}

class RestaurantsError extends RestaurantsState {
  const RestaurantsError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
