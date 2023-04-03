import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/error.dart';

import '../../../../core/loading.dart';
import '../map_cubit/map_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;

  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(37.4279, -122.0857), zoom: 14.4746);
  static final CameraPosition _kLake =
      CameraPosition(bearing: 192.8334, target: LatLng(37.4329, -122.0883), tilt: 59.4407, zoom: 19.1519);

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
            mapType: MapType.normal,
            markers: state.markers,
            initialCameraPosition: CameraPosition(
              bearing: 190,
              target: LatLng(state.userLocation.latitude, state.userLocation.longitude),
              zoom: 11.4746,
            ),
            // initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) => onMapCreated(controller, state),
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }

  void onMapCreated(GoogleMapController controller, MapLocationsFound state) async {
    _controller = controller;
    //   CameraPosition(
    //         bearing: 190,
    //         target: LatLng(state.userLocation.latitude, state.userLocation.longitude),
    //         zoom: 11.4746,
    //       )
    // _controller.animateCamera(cameraUpdate)
  }
}
