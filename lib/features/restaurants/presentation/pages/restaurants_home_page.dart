import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurants_found_body.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class RestaurantsHomePage extends StatelessWidget {
  RestaurantsHomePage({super.key});

  static const String id = '/restaurantsHomepage';

  Position? userCurrentLocation;

  double setRadius = kOneMile * 3;

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
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          userCurrentLocation = context.read<RestaurantsBloc>().currentLocation;

          if (locationChanged(state)) {
            setRadius = context.read<RestaurantsNearMeProvider>().radius;
            debugPrint('Getting Restaurants');
            BlocProvider.of<RestaurantsBloc>(
              context,
            ).add(const LoadGeolocationEvent());
            context.read<RestaurantsBloc>().currentLocation = state.position;
            userCurrentLocation = state.position;

            debugPrint(
              'userCurrentLocation: ${userCurrentLocation?.latitude}'
              ' ${userCurrentLocation?.longitude}',
            );
            BlocProvider.of<RestaurantsBloc>(context).add(
              GetRestaurantsEvent(
                position: state.position,
                radius: setRadius,
              ),
            );
          }
        } else if (setRadius != context.read<RestaurantsNearMeProvider>().radius) {
          setRadius = context.read<RestaurantsNearMeProvider>().radius;
          BlocProvider.of<RestaurantsBloc>(context).add(
            GetRestaurantsEvent(
              position: userCurrentLocation!,
              radius: setRadius,
            ),
          );
        }
        if (state is RestaurantsLoaded) {
          BlocProvider.of<RestaurantsBloc>(
            context,
          ).restaurants = state.restaurants..sort(sortByDistance);
          restaurants = state.restaurants..sort(sortByDistance);
          BlocProvider.of<RestaurantsBloc>(context).add(
            GetRestaurantsMarkersEvent(
              restaurants: state.restaurants,
            ),
          );
        }
        if (state is MarkersLoaded) {
          BlocProvider.of<RestaurantsBloc>(context).markers = state.markers;
          markers = state.markers;
        }
      },
      builder: (context, state) {
        if (state is LoadingMarkers) {
          currentPage = const LoadingPage();
          return const LoadingPage();
        } else if (state is MarkersLoaded) {
          userCurrentLocation = BlocProvider.of<RestaurantsBloc>(
            context,
          ).currentLocation;
          restaurants = BlocProvider.of<RestaurantsBloc>(
            context,
          ).restaurants;
          markers = BlocProvider.of<RestaurantsBloc>(
            context,
          ).markers;
          currentPage = RestaurantsFoundBody(
            restaurants: restaurants!,
            userLocation: userCurrentLocation!,
            markers: markers!,
          );
          return RestaurantsFoundBody(
            restaurants: restaurants!,
            userLocation: userCurrentLocation!,
            markers: markers!,
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
      a.geometry.location.lat,
      a.geometry.location.lng,
    );
    final distanceB = Geolocator.distanceBetween(
      userCurrentLocation?.latitude ?? 0,
      userCurrentLocation?.longitude ?? 0,
      b.geometry.location.lat,
      b.geometry.location.lng,
    );
    return distanceA.compareTo(distanceB);
  }
}
