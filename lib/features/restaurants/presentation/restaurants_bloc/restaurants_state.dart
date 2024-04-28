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

class LoadingUserGeoLocation extends RestaurantsState {
  const LoadingUserGeoLocation();
}

class LoadingMarkers extends RestaurantsState {
  const LoadingMarkers();
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

class FetchingSavedRestaurantsList extends RestaurantsState {
  const FetchingSavedRestaurantsList();
}

class SavedRestaurantsListFetched extends RestaurantsState {
  const SavedRestaurantsListFetched({
    required this.savedRestaurantsList,
  });

  final List<RestaurantDetails> savedRestaurantsList;
}

class SavingRestaurant extends RestaurantsState {
  const SavingRestaurant();
}

class RemovingRestaurant extends RestaurantsState {
  const RemovingRestaurant();
}

class AddingRestaurantReview extends RestaurantsState {
  const AddingRestaurantReview();
}

class LoadingRestaurantReviews extends RestaurantsState {
  const LoadingRestaurantReviews();
}

class RestaurantReviewAdded extends RestaurantsState {
  const RestaurantReviewAdded();
}

class RestaurantReviewsLoaded extends RestaurantsState {
  const RestaurantReviewsLoaded({
    required this.restaurantReviews,
  });

  final List<RestaurantReview> restaurantReviews;
}

class UserLocationLoaded extends RestaurantsState {
  const UserLocationLoaded({required this.position});

  final Position position;

  @override
  List<Object> get props => [position];
}

class MarkersLoaded extends RestaurantsState {
  const MarkersLoaded({required this.markers});

  final Set<Marker> markers;

  @override
  List<Object> get props => [markers];
}

class RestaurantsError extends RestaurantsState {
  const RestaurantsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
