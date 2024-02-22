import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/common/screens/error/error.dart';
import '../../../../core/common/screens/loading/loading.dart';
import '../geolocation_bloc/geolocation_bloc.dart';
import '../map_cubit/map_cubit.dart';
import '../restaurants_bloc/restaurants_bloc.dart';
import 'componets/restaurant_card.dart';
import 'componets/restaurants_found_state_page.dart';
import 'map_page.dart';

class RestaurantsHomePage extends StatefulWidget {
  static const String id = "/restaurantsHomepage";

  RestaurantsHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantsHomePage> createState() => _RestaurantsHomePageState();
}

class _RestaurantsHomePageState extends State<RestaurantsHomePage> {
  RestaurantsState? previousState;
  Position? userCurrentLocation;

  Widget currentPage = Container();

  @override
  Widget build(BuildContext buildContext) {
    // BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent());
    return MultiBlocListener(
      listeners: [
        BlocListener<GeolocationBloc, GeolocationState>(
          listener: (context, state) {
            userCurrentLocation = BlocProvider.of<GeolocationBloc>(context).currentLocation;
            if (state is GeolocationLoadedState) {
              if (userCurrentLocation == null ||
                  userCurrentLocation?.latitude.toStringAsFixed(3) != state.position.latitude.toStringAsFixed(3) ||
                  userCurrentLocation?.longitude.toStringAsFixed(3) !=
                      state.position.longitude.toStringAsFixed(3)) {
                debugPrint("Getting Restaurants");
                BlocProvider.of<GeolocationBloc>(context).currentLocation = state.position;
                userCurrentLocation = state.position;
                debugPrint(
                    "userCurrentLocation: ${userCurrentLocation?.latitude} ${userCurrentLocation?.longitude}");
                BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent(position: state.position));
              }
            }
          },
        ),
        BlocListener<RestaurantsBloc, RestaurantsState>(
          listener: (context, state) {
            if (state is RestaurantsFoundState) {
              debugPrint("restaurants found");
              BlocProvider.of<MapCubit>(context).displayRestaurants(state.restaurants, userCurrentLocation!);
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(buildContext).requestFocus(new FocusNode());
        },
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoadingState) {
              currentPage = LoadingPage();
              return LoadingPage();
            } else if (state is RestaurantsFoundState) {
              currentPage = RestaurantsFoundStatePage();
              return RestaurantsFoundStatePage();
            } else if (state is RestaurantsErrorState) {
              currentPage = ErrorPage(error: state.error);
              return ErrorPage(
                error: state.error,
              );
            } else {
              if (userCurrentLocation == null) {
                currentPage = LoadingPage();
              }
              return currentPage;
            }
          },
        ),
      ),
    );
  }
}
