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

  late List<Restaurant>? restaurants;

  late Set<Marker>? markers;

  Widget currentPage = Container();

  // @override
  bool locationChanged(UserLocationLoaded state) {
    return userCurrentLocation == null ||
        userCurrentLocation?.latitude.toStringAsFixed(3) !=
            state.position.latitude.toStringAsFixed(
              3,
            ) ||
        userCurrentLocation?.longitude.toStringAsFixed(3) !=
            state.position.longitude.toStringAsFixed(
              3,
            );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          // store previous location into local variable
          userCurrentLocation = context.read<RestaurantsNearMeProvider>().currentLocation;

          // if previous location is not the same as location just loaded ..
          if (locationChanged(state)) {
            // store location loaded in provider variable ...
            context.read<RestaurantsNearMeProvider>().currentLocation = state.position;
            // and local variable
            userCurrentLocation = state.position;
            debugPrint(
              'userCurrentLocation: ${userCurrentLocation?.latitude}'
              ' ${userCurrentLocation?.longitude}',
            );
            BlocProvider.of<RestaurantsCubit>(context).getRestaurants(
              state.position,
              context.read<RestaurantsNearMeProvider>().radius,
            );
          }
        }

        if (state is RestaurantsLoaded) {
          debugPrint('RestaurantsLoaded');
          context.read<RestaurantsNearMeProvider>().restaurants = state.restaurants..sort(sortByDistance);
          restaurants = state.restaurants..sort(sortByDistance);
          BlocProvider.of<RestaurantsCubit>(context).getRestaurantsMarkers(
            state.restaurants,
          );
        }

        if (state is MarkersLoaded) {
          debugPrint('MarkersLoaded');
          context.read<RestaurantsNearMeProvider>().markers = state.markers;
          markers = state.markers;
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
          userCurrentLocation = context.read<RestaurantsNearMeProvider>().currentLocation;
          restaurants = context.read<RestaurantsNearMeProvider>().restaurants;
          markers = context.read<RestaurantsNearMeProvider>().markers;
          currentPage = RestaurantsFoundBody(
            restaurants: restaurants ?? [],
            userLocation: userCurrentLocation ??
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
            markers: markers ?? <Marker>{},
          );
          return RestaurantsFoundBody(
            restaurants: restaurants ?? [],
            userLocation: userCurrentLocation ??
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
            markers: markers ?? <Marker>{},
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
