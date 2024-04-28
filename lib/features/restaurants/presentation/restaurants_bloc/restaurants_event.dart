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

class FetchSavedRestaurantsListEvent extends RestaurantsEvent {
  const FetchSavedRestaurantsListEvent({required this.savedRestaurantsIdsList});

  final List<String> savedRestaurantsIdsList;
}

class RemoveRestaurantEvent extends RestaurantsEvent {
  const RemoveRestaurantEvent({required this.restaurant});

  final RestaurantDetails restaurant;
}

class SaveRestaurantEvent extends RestaurantsEvent {
  const SaveRestaurantEvent({required this.restaurant});

  final RestaurantDetails restaurant;
}

class AddRestaurantReviewEvent extends RestaurantsEvent {
  const AddRestaurantReviewEvent({required this.restaurantReview});

  final RestaurantReview restaurantReview;
}

class GetRestaurantReviewsEvent extends RestaurantsEvent {
  const GetRestaurantReviewsEvent({required this.restaurantId});

  final String restaurantId;
}
