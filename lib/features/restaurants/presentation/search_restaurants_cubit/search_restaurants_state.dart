part of 'search_restaurants_cubit.dart';

abstract class SearchRestaurantsState extends Equatable {
  const SearchRestaurantsState();

  @override
  List<Object> get props => [];
}

class SearchRestaurantsInitial extends SearchRestaurantsState {
  const SearchRestaurantsInitial();
}

class SearchingRestaurants extends SearchRestaurantsState {
  const SearchingRestaurants();
}

class RestaurantsSearched extends SearchRestaurantsState {
  const RestaurantsSearched({required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class SearchRestaurantsError extends SearchRestaurantsState {
  const SearchRestaurantsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
