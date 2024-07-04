import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/resources/media_resources.dart';

import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/themes/app_theme.dart';

class GoogleMapPlugin {
  Future<MapModel> getRestaurantsMarkers({required List<Restaurant> restaurants}) async {
    final restaurantsMarkers = <Marker>{};
    for (var index = 0; index < restaurants.length; index++) {
      final restaurant = restaurants[index];
      final name = restaurant.name;
      final latitude = restaurant.geoLocation.lat;
      final longitude = restaurant.geoLocation.lng;
      final snippet = '${restaurant.streetAddress}, ${restaurant.city}, '
          '${restaurant.state} ${restaurant.zipCode}';
      final markerIcon = await getBytesFromAsset(MediaResources.broccoli, 100);

      final customIcon = await getMarkerIcon(MediaResources.tofu, true, Size(150, 150));
      // final icon = await Container(
      //   height: 35,
      //   width: 35,
      //   decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      //   child: Image.asset(
      //     MediaResources.tofu,
      //     height: 20,
      //     width: 20,
      //   ),
      // ).toBitmapDescriptor();
      restaurantsMarkers.add(
        Marker(
          markerId: MarkerId(name),
          infoWindow: InfoWindow(
            title: name,
            snippet: snippet,
            anchor: const Offset(0.5, -0.1),
          ),
          position: LatLng(latitude, longitude),
          // icon: icon,
          // icon: BitmapDescriptor.fromBytes(markerIcon!),
          icon: customIcon,
          anchor: const Offset(0.1, 0.8),
        ),
      );
    }
    return MapModel(markers: restaurantsMarkers);
  }

  Future<Uint8List?> getBytesFromAsset(
    String path,
    int width,
  ) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getMarkerIcon(
    String imageUrl,
    bool isFromAsset,
    Size size,
  ) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final radius = Radius.circular(size.width / 2);

    final shadowPaint = Paint()..color = AppTheme.lightPrimaryColor.withAlpha(100);
    const shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;

    // Shadow circle
    canvas
      ..drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint,
      )

      // Border circle
      ..drawRRect(
          RRect.fromRectAndCorners(
            Rect.fromLTWH(
                shadowWidth, shadowWidth, size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
          ),
          borderPaint);

    // Oval for the image
    Rect oval =
        Rect.fromLTWH(imageOffset, imageOffset, size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Clip oval path for image
    canvas.clipPath(Path()..addOval(oval));

    // Fetch and draw the network image
    ui.Image image = isFromAsset ? await _fetchAssetsImage(imageUrl) : await _fetchNetworkImage(imageUrl);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

    // Convert canvas to image
    final ui.Image markerAsImage =
        await pictureRecorder.endRecording().toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> _fetchNetworkImage(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<ui.Image> _fetchAssetsImage(String imageUrl) async {
    ByteData data = await rootBundle.load(imageUrl);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
