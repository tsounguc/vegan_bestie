part of 'restaurants_cubit.dart';

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

class AddingRestaurant extends RestaurantsState {
  const AddingRestaurant();
}

class SubmittingRestaurant extends RestaurantsState {
  const SubmittingRestaurant();
}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded({required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class RestaurantDetailsLoaded extends RestaurantsState {
  const RestaurantDetailsLoaded({required this.restaurant});

  final Restaurant restaurant;

  @override
  List<Object> get props => [restaurant];
}

class FetchingSavedRestaurantsList extends RestaurantsState {
  const FetchingSavedRestaurantsList();
}

class SavedRestaurantsListFetched extends RestaurantsState {
  const SavedRestaurantsListFetched({
    required this.savedRestaurantsList,
  });

  final List<Restaurant> savedRestaurantsList;
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

class DeletingRestaurantReview extends RestaurantsState {
  const DeletingRestaurantReview();
}

class DeletingRestaurantSubmit extends RestaurantsState {
  const DeletingRestaurantSubmit();
}

class RestaurantAdded extends RestaurantsState {
  const RestaurantAdded();
}

class RestaurantSubmitted extends RestaurantsState {
  const RestaurantSubmitted();
}

class RestaurantReviewDeleted extends RestaurantsState {
  const RestaurantReviewDeleted();
}

class RestaurantSubmitDeleted extends RestaurantsState {
  const RestaurantSubmitDeleted();
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

class EditingRestaurantReview extends RestaurantsState {
  const EditingRestaurantReview();
}

class RestaurantReviewEdited extends RestaurantsState {
  const RestaurantReviewEdited();
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
