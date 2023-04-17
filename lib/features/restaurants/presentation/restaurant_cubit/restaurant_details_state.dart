part of 'restaurant_details_cubit.dart';

@immutable
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
  final RestaurantDetailsEntity? restaurantDetailsEntity;

  RestaurantDetailsFoundState({required this.restaurantDetailsEntity});

  @override
  List<Object?> get props => [];
}

class RestaurantDetailsErrorState extends RestaurantDetailsState {
  final error;

  RestaurantDetailsErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
