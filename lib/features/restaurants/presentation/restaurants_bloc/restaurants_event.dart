part of 'restaurants_bloc.dart';

abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadGeolocationEvent extends RestaurantsEvent {
  const LoadGeolocationEvent();
}

class GetRestaurantsEvent extends RestaurantsEvent {
  const GetRestaurantsEvent({required this.position});

  final Position position;

  @override
  List<Object> get props => [position];
}

class GetRestaurantDetailsEvent extends RestaurantsEvent {
  const GetRestaurantDetailsEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

class GetRestaurantsMarkersEvent extends RestaurantsEvent {
  const GetRestaurantsMarkersEvent({required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}
