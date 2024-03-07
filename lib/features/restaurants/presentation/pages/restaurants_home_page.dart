import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';
import 'package:sheveegan/features/restaurants/presentation/map_cubit/map_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurants_found_state_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class RestaurantsHomePage extends StatefulWidget {
  const RestaurantsHomePage({super.key});

  static const String id = '/restaurantsHomepage';

  @override
  State<RestaurantsHomePage> createState() => _RestaurantsHomePageState();
}

class _RestaurantsHomePageState extends State<RestaurantsHomePage> {
  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold();
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
