import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    required this.userLocation,
    required this.markers,
    super.key,
  });

  final Position userLocation;

  final Set<Marker> markers;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool cameraMoved = false;

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.userLocation.latitude,
        widget.userLocation.longitude,
      ),
      zoom: 11.4746,
    );

    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: widget.markers,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller) => _onMapCreated(
        context,
        controller,
      ),
      onCameraIdle: () {
        timer = Timer(
          const Duration(milliseconds: 7500),
          () {
            context.mapController?.animateCamera(
              CameraUpdate.newLatLngBounds(
                MapUtils.boundsFromLatLngList(
                  widget.markers.map((location) => location.position).toList(),
                ),
                30,
              ),
            );
          },
        );
        debugPrint('onCameraIdle');
      },
      onCameraMoveStarted: () {
        timer?.cancel();
        debugPrint('onCameraMoveStarted');
      },
      indoorViewEnabled: true,
    );
  }

  Future<void> _onMapCreated(
    BuildContext context,
    GoogleMapController controller,
  ) async {
    context.restaurantsNearMeProvider.mapController = controller;

    centerMap(context);
  }

  void centerMap(BuildContext context, {Duration? delayDuration}) {
    Future.delayed(
      delayDuration ?? Duration(milliseconds: 200),
      () => context.mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          MapUtils.boundsFromLatLngList(
            widget.markers.map((location) => location.position).toList(),
          ),
          30,
        ),
      ),
    );
  }
}

//https://www.appsloveworld.com/flutter/100/47/keep-all-markers-in-view-with-flutter-google-maps-plugin
class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0;
    double? x1;
    double? y0;
    double? y1;
    for (final latLng in list) {
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
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}
