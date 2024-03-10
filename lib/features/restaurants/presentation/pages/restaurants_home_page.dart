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
  late Position userLocation;
  late List<Restaurant> restaurants;
  late Set<Marker> markers;
  Widget currentPage = Container();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {
        if (state is UserLocationLoaded) {
          userLocation = state.position;

          if (userLocation.latitude.toStringAsFixed(3) != state.position.latitude.toStringAsFixed(3) ||
              userLocation.longitude.toStringAsFixed(3) != state.position.longitude.toStringAsFixed(3)) {
            debugPrint('Getting Restaurants');
            BlocProvider.of<RestaurantsBloc>(
              context,
            ).add(const LoadGeolocationEvent());
            userLocation = state.position;
            debugPrint(
              'userCurrentLocation: ${userLocation.latitude}'
              ' ${userLocation.longitude}',
            );
            BlocProvider.of<RestaurantsBloc>(context).add(
              GetRestaurantsEvent(
                position: state.position,
              ),
            );
          }
        }

        if (state is RestaurantsLoaded) {
          restaurants = state.restaurants;
          BlocProvider.of<RestaurantsBloc>(context).add(
            GetRestaurantsMarkersEvent(
              restaurants: state.restaurants,
            ),
          );
        }
        if (state is MarkersLoaded) {
          markers = state.markers;
        }
      },
      builder: (context, state) {
        if (state is MarkersLoaded) {
          return RestaurantsFoundBody(
            restaurants: restaurants,
            userLocation: userLocation,
            markers: markers,
          );
        } else if (state is RestaurantsError) {
          return ErrorPage(error: state.message);
        } else {
          return const LoadingPage();
        }
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
