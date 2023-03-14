import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/data/models/google_restaurants_search_model.dart';
import 'package:sheveegan/data/models/yelp_restaurants_search_model.dart';
import 'package:sheveegan/data/repositoryLayer/repository.dart';

import '../../../../data/models/restaurants_search_model.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  final Repository repository;
  YelpRestaurantsSearchModel? _results;
  RestaurantsBloc({required this.repository}) : super(RestaurantsInitialState()) {
    on<GetRestaurantsEvent>((event, emit) async {
      try {
        emit(RestaurantsLoadingState());
        _results = await repository.getRestaurantsNearMe(event.position!);
        emit(RestaurantsFoundState(results: _results));
      } on Error catch (e) {
        print(e);
        throw Exception(e.stackTrace);
      } catch (e) {}
    });
  }
}
