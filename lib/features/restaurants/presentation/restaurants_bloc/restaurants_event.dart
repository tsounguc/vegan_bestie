part of 'restaurants_bloc.dart';

abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();

  @override
  List<Object> get props => [];
}

class LoadGeolocationEvent extends RestaurantsEvent {
  const LoadGeolocationEvent();
}

class AddRestaurantEvent extends RestaurantsEvent {
  const AddRestaurantEvent({
    required this.restaurant,
  });

  final Restaurant restaurant;
}

class GetRestaurantsEvent extends RestaurantsEvent {
  const GetRestaurantsEvent({
    required this.position,
    required this.radius,
  });

  final Position position;
  final double radius;

  @override
  List<Object> get props => [position, radius];
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

  final Restaurant restaurant;
}

class SaveRestaurantEvent extends RestaurantsEvent {
  const SaveRestaurantEvent({required this.restaurant});

  final Restaurant restaurant;
}

class AddRestaurantReviewEvent extends RestaurantsEvent {
  const AddRestaurantReviewEvent({required this.restaurantReview});

  final RestaurantReview restaurantReview;
}

class GetRestaurantReviewsEvent extends RestaurantsEvent {
  const GetRestaurantReviewsEvent({required this.restaurantId});

  final String restaurantId;
}

class DeleteRestaurantReviewEvent extends RestaurantsEvent {
  const DeleteRestaurantReviewEvent({required this.review});

  final RestaurantReview review;
}

class EditRestaurantReviewEvent extends RestaurantsEvent {
  const EditRestaurantReviewEvent({required this.review});

  final RestaurantReview review;
}
