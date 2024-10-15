import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/search_restaurants.dart';

part 'search_restaurants_state.dart';

class SearchRestaurantsCubit extends Cubit<SearchRestaurantsState> {
  SearchRestaurantsCubit({required SearchRestaurants searchRestaurants})
      : _searchRestaurants = searchRestaurants,
        super(const SearchRestaurantsInitial());

  final SearchRestaurants _searchRestaurants;

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      emit(const RestaurantsSearched(restaurants: []));
      return;
    }

    emit(const SearchingRestaurants());

    final result = await _searchRestaurants(query);

    result.fold(
      (failure) => emit(SearchRestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsSearched(restaurants: restaurants)),
    );
  }
}
