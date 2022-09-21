part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
}

class RestaurantsInitialState extends RestaurantsState {
  @override
  List<Object> get props => [];
}

class RestaurantsFoundState extends RestaurantsState {
  final YelpRestaurantsSearchModel? results;
  RestaurantsFoundState({required this.results});
  @override
  List<Object> get props => [];
}

class RestaurantsLoadingState extends RestaurantsState {
  @override
  List<Object?> get props => [];
}
