import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurants_found_body.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

//ignore: must_be_immutable
class RestaurantsHomePage extends StatelessWidget {
  RestaurantsHomePage({super.key});

  static const String id = '/restaurantsHomepage';

  Position? userCurrentLocation;

  Widget currentPage = Container();

  // @override
  bool checkLocation(
    BuildContext context, {
    required Position position,
  }) {
    final userLocation = context.currentLocation;
    return userLocation == null ||
        userLocation.latitude.toStringAsFixed(3) !=
            position.latitude.toStringAsFixed(
              3,
            ) ||
        userLocation.longitude.toStringAsFixed(3) !=
            position.longitude.toStringAsFixed(
              3,
            );
  }

  @override
  Widget build(BuildContext context) {
    if (context.currentLocation == null) {
      BlocProvider.of<RestaurantsCubit>(
        context,
      ).loadGeoLocation();
    }
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          // store previous location into local variable
          final locationChanged = checkLocation(context, position: state.position);
          // if previous location is not the same as location just loaded ..
          if (locationChanged) {
            // store location loaded in provider variable ...
            context.restaurantsNearMeProvider.currentLocation = state.position;
            // and local variable
            userCurrentLocation = state.position;
            debugPrint(
              'userCurrentLocation: ${state.position.latitude}'
              ' ${state.position.longitude}',
            );
            BlocProvider.of<RestaurantsCubit>(context).getRestaurants(
              state.position,
              context.radius,
            );
          }
        }

        if (state is RestaurantsLoaded) {
          debugPrint('RestaurantsLoaded');
          context.restaurantsNearMeProvider.restaurants = state.restaurants..sort(sortByDistance);
          BlocProvider.of<RestaurantsCubit>(context).getRestaurantsMarkers(
            state.restaurants,
          );
        }

        if (state is MarkersLoaded) {
          debugPrint('MarkersLoaded');
          context.restaurantsNearMeProvider.markers = state.markers;
        }

        if (state is SavedRestaurantsListFetched) {
          context.savedRestaurantsProvider.savedRestaurantsList = state.savedRestaurantsList;
        }
      },
      builder: (context, state) {
        if (state is LoadingRestaurants || state is LoadingMarkers) {
          currentPage = const LoadingPage();
          return const LoadingPage();
        } else if (state is MarkersLoaded) {
          return RestaurantsFoundBody(
            restaurants: context.restaurants ?? [],
            userLocation: context.currentLocation ??
                Position(
                  longitude: 0,
                  latitude: 0,
                  timestamp: DateTime.now(),
                  accuracy: 0,
                  altitude: 0,
                  altitudeAccuracy: 0,
                  heading: 0,
                  headingAccuracy: 0,
                  speed: 0,
                  speedAccuracy: 0,
                ),
            markers: context.markers ?? <Marker>{},
          );
        } else if (state is RestaurantsError) {
          currentPage = ErrorPage(error: state.message);
          return ErrorPage(error: state.message);
        } else {
          if (userCurrentLocation == null) {
            currentPage = const LoadingPage();
          }
          return currentPage;
        }
      },
    );
  }

  int sortByDistance(Restaurant a, Restaurant b) {
    final distanceA = Geolocator.distanceBetween(
      userCurrentLocation?.latitude ?? 0,
      userCurrentLocation?.longitude ?? 0,
      a.geoLocation.lat,
      a.geoLocation.lng,
    );
    final distanceB = Geolocator.distanceBetween(
      userCurrentLocation?.latitude ?? 0,
      userCurrentLocation?.longitude ?? 0,
      b.geoLocation.lat,
      b.geoLocation.lng,
    );
    return distanceA.compareTo(distanceB);
  }
}
