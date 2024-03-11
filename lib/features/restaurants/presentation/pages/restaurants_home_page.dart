import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurants_found_body.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class RestaurantsHomePage extends StatefulWidget {
  const RestaurantsHomePage({super.key});

  static const String id = '/restaurantsHomepage';

  @override
  State<RestaurantsHomePage> createState() => _RestaurantsHomePageState();
}

class _RestaurantsHomePageState extends State<RestaurantsHomePage> {
  Position? userCurrentLocation;
  late List<Restaurant>? restaurants;
  late Set<Marker>? markers;
  Widget currentPage = Container();

  // @override
  // void initState() {
  //   userCurrentLocation = context.read<RestaurantsBloc>().currentLocation;
  //   super.initState();
  // }

  bool locationChanged(UserLocationLoaded state) {
    final latitude = userCurrentLocation?.latitude;
    final longitude = userCurrentLocation?.longitude;
    return userCurrentLocation == null ||
        latitude?.toStringAsFixed(3) != state.position.latitude.toStringAsFixed(3) ||
        longitude?.toStringAsFixed(3) != state.position.longitude.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          userCurrentLocation = context.read<RestaurantsBloc>().currentLocation;

          if (locationChanged(state)) {
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
              ),
            );
          }
        }

        if (state is RestaurantsLoaded) {
          BlocProvider.of<RestaurantsBloc>(context).restaurants = state.restaurants;
          BlocProvider.of<RestaurantsBloc>(context).add(
            GetRestaurantsMarkersEvent(
              restaurants: state.restaurants,
            ),
          );
        }
        if (state is MarkersLoaded) {
          BlocProvider.of<RestaurantsBloc>(context).markers = state.markers;
          // markers = state.markers;
        }
      },
      builder: (context, state) {
        userCurrentLocation = BlocProvider.of<RestaurantsBloc>(context).currentLocation;
        restaurants = BlocProvider.of<RestaurantsBloc>(context).restaurants;
        markers = BlocProvider.of<RestaurantsBloc>(context).markers;
        if (state is LoadingUserGeoLocation || state is LoadingRestaurants || state is LoadingUserGeoLocation) {
          currentPage = const LoadingPage();
          return const LoadingPage();
        } else if (state is MarkersLoaded) {
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
        return currentPage;
      },
    );
  }
}

// class RestaurantsHomePage extends StatefulWidget {
//   const RestaurantsHomePage({super.key});
//
//   static const String id = '/restaurantsHomepage';
//
//   @override
//   State<RestaurantsHomePage> createState() => _RestaurantsHomePageState();
// }
//
// class _RestaurantsHomePageState extends State<RestaurantsHomePage> {
//   RestaurantsState? previousState;
//   Position? userCurrentLocation;
//
//   Widget currentPage = Container();
//
//   @override
//   Widget build(BuildContext buildContext) {
//     // BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent());
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<GeolocationBloc, GeolocationState>(
//           listener: (context, state) {
//             userCurrentLocation = BlocProvider.of<GeolocationBloc>(
//               context,
//             ).currentLocation;
//             if (state is GeolocationLoadedState) {
//               if (userCurrentLocation == null ||
//                   userCurrentLocation?.latitude.toStringAsFixed(3) != state.position.latitude.toStringAsFixed(3) ||
//                   userCurrentLocation?.longitude.toStringAsFixed(3) !=
//                       state.position.longitude.toStringAsFixed(3)) {
//                 debugPrint('Getting Restaurants');
//                 BlocProvider.of<GeolocationBloc>(
//                   context,
//                 ).currentLocation = state.position;
//                 userCurrentLocation = state.position;
//                 debugPrint(
//                   'userCurrentLocation: ${userCurrentLocation?.latitude}'
//                   ' ${userCurrentLocation?.longitude}',
//                 );
//                 BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent(
//                   position: state.position,
//                 ));
//               }
//             }
//           },
//         ),
//         BlocListener<RestaurantsBloc, RestaurantsState>(
//           listener: (context, state) {
//             if (state is RestaurantsLoaded) {
//               debugPrint('restaurants found');
//               BlocProvider.of<MapCubit>(context).displayRestaurants(
//                 state.restaurants,
//                 userCurrentLocation!,
//               );
//             }
//           },
//         ),
//       ],
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(buildContext).requestFocus(FocusNode());
//         },
//         child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
//           builder: (context, state) {
//             if (state is LoadingRestaurants) {
//               currentPage = const LoadingPage();
//               return const LoadingPage();
//             } else if (state is RestaurantsLoaded) {
//               currentPage = const RestaurantsFoundStatePage();
//               return const RestaurantsFoundStatePage();
//             } else if (state is RestaurantsError) {
//               currentPage = ErrorPage(error: state.message as String);
//               return ErrorPage(
//                 error: state.message as String,
//               );
//             } else {
//               if (userCurrentLocation == null) {
//                 currentPage = const LoadingPage();
//               }
//               return currentPage;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
