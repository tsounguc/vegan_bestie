import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/error.dart';

import '../../../../core/loading.dart';
import '../geolocation_bloc/geolocation_bloc.dart';
import '../map_cubit/map_cubit.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapErrorState) {
          ErrorPage(error: state.error);
        }
        if (state is MapLocationsFound) {
          debugPrint(state.markers.first.mapsId.value);
          return GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            markers: state.markers,
            // trafficEnabled: true,
            // cameraTargetBounds: CameraTargetBounds(
            //   MapUtils.boundsFromLatLngList(state.markers.map((location) => location.position).toList()),
            // ),
            initialCameraPosition: CameraPosition(
              // bearing: 190,
              target: LatLng(state.userLocation.latitude, state.userLocation.longitude),
              // zoom: 12
              zoom: 11.4746,
            ),
            onMapCreated: (GoogleMapController controller) => _onMapCreated(context, controller, state),
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }

  void _onMapCreated(BuildContext context, GoogleMapController controller, MapLocationsFound state) async {
    BlocProvider.of<MapCubit>(context).controller = controller;
    // userCurrentLocation = state.userLocation;

    Future.delayed(
      Duration(milliseconds: 200),
      () => context.read<MapCubit>().controller?.animateCamera(
            CameraUpdate.newLatLngBounds(
              MapUtils.boundsFromLatLngList(
                state.markers.map((location) => location.position).toList(),
              ),
              30,
            ),
          ),
    );
  }
}

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   GoogleMapController? _controller;
//   Position? userCurrentLocation;
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller?.dispose();
//   }
//
//   static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(37.4279, -122.0857), zoom: 14.4746);
//   static final CameraPosition _kLake =
//       CameraPosition(bearing: 192.8334, target: LatLng(37.4329, -122.0883), tilt: 59.4407, zoom: 19.1519);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MapCubit, MapState>(
//       builder: (context, state) {
//         if (state is MapErrorState) {
//           ErrorPage(error: state.error);
//         }
//         if (state is MapLocationsFound) {
//           debugPrint(state.markers.first.mapsId.value);
//           return GoogleMap(
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             mapType: MapType.normal,
//             markers: state.markers,
//             // trafficEnabled: true,
//             // cameraTargetBounds: CameraTargetBounds(
//             //   MapUtils.boundsFromLatLngList(state.markers.map((location) => location.position).toList()),
//             // ),
//             initialCameraPosition: CameraPosition(
//               // bearing: 190,
//               target: LatLng(state.userLocation.latitude, state.userLocation.longitude),
//               // zoom: 11.4746,
//             ),
//             onMapCreated: (GoogleMapController controller) => _onMapCreated(controller, state),
//           );
//         } else {
//           return LoadingPage();
//         }
//       },
//     );
//   }
//
//   void _onMapCreated(GoogleMapController controller, MapLocationsFound state) async {
//     _controller = controller;
//     userCurrentLocation = BlocProvider.of<GeolocationBloc>(context).currentLocation;
//
//     Future.delayed(
//       Duration(milliseconds: 200),
//       () => _controller?.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           MapUtils.boundsFromLatLngList(state.markers.map((location) => location.position).toList()),
//           1,
//         ),
//       ),
//     );
//   }
// }

//https://www.appsloveworld.com/flutter/100/47/keep-all-markers-in-view-with-flutter-google-maps-plugin
class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
