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

class AddingRestaurant extends RestaurantsState {
  const AddingRestaurant();
}

class SubmittingRestaurant extends RestaurantsState {
  const SubmittingRestaurant();
}

class UpdatingRestaurant extends RestaurantsState {
  const UpdatingRestaurant();
}

class RestaurantUpdated extends RestaurantsState {
  const RestaurantUpdated();
}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded({
    required this.restaurants,
    required this.hasReachedEnd,
    required this.markers,
  });

  final List<Restaurant> restaurants;
  final bool hasReachedEnd;
  final Set<Marker> markers;

  @override
  List<Object> get props => [restaurants, hasReachedEnd, markers];
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

class RestaurantSaved extends RestaurantsState {
  const RestaurantSaved();
}

class UnSavingRestaurant extends RestaurantsState {
  const UnSavingRestaurant();
}

class RestaurantUnSaved extends RestaurantsState {
  const RestaurantUnSaved();
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

class RestaurantsError extends RestaurantsState {
  const RestaurantsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
