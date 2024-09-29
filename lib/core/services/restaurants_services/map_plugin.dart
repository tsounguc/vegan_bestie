import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/features/restaurants/data/models/map_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/themes/app_theme.dart';

class GoogleMapPlugin {
  Future<MapModel> getRestaurantsMarkers({
    required List<Restaurant> restaurants,
  }) async {
    final restaurantsMarkers = <Marker>{};
    for (var index = 0; index < restaurants.length; index++) {
      final restaurant = restaurants[index];
      final name = restaurant.name;
      final latitude = restaurant.geoLocation.lat;
      final longitude = restaurant.geoLocation.lng;
      final snippet = '${restaurant.streetAddress}, ${restaurant.city}, '
          '${restaurant.state}';

      final isFromAsset = restaurant.thumbnail == null;

      final imageUrl = isFromAsset ? MediaResources.tofu : restaurant.thumbnail;

      final customIcon = await getMarkerIcon(
        imageUrl!,
        Size(70.r, 70.r),
        isFromAsset: isFromAsset,
      );

      restaurantsMarkers.add(
        Marker(
          markerId: MarkerId(name),
          infoWindow: InfoWindow(
            title: name,
            snippet: snippet,
            anchor: const Offset(0.5, -0.1),
            onTap: () {
              // navigatorKey.currentState?.pushNamed(
              //   RestaurantDetailsPage.id,
              //   arguments: restaurant,
              // );
            },
          ),
          position: LatLng(latitude, longitude),
          icon: customIcon,
          // anchor: const Offset(0.1, 0.8),
        ),
      );
    }
    return MapModel(markers: restaurantsMarkers);
  }

  Future<Uint8List?> getBytesFromAsset(
    String path,
    int width,
  ) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getMarkerIcon(
    String imageUrl,
    Size size, {
    required bool isFromAsset,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final radius = Radius.circular(size.width / 2);

    final shadowPaint = Paint()..color = AppTheme.lightPrimaryColor.withAlpha(100);
    const shadowWidth = 8.0;

    final borderPaint = Paint()..color = Colors.white;
    const borderWidth = 2.0;

    const imageOffset = shadowWidth + borderWidth;

    const triangleH = 100;
    const triangleW = 25.0;
    // Shadow circle
    canvas
      ..drawPath(
        Path()
          ..moveTo(size.width / 2 - triangleW / 2, size.height)
          ..lineTo(size.width / 2, triangleH + size.height)
          ..lineTo(size.width / 2 + triangleW, size.height)
          ..arcToPoint(
            Offset(size.width / 2, triangleH + size.height),
          ),
        shadowPaint,
      )
      ..drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width, size.height),
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
            shadowWidth,
            shadowWidth,
            size.width - (shadowWidth * 2),
            size.height - (shadowWidth * 2),
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint,
      );

    // Oval for the image
    final oval =
        Rect.fromLTWH(imageOffset, imageOffset, size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Clip oval path for image
    canvas.clipPath(Path()..addOval(oval));

    // Fetch and draw the network image
    final image = isFromAsset ? await _fetchAssetsImage(imageUrl) : await _fetchNetworkImage(imageUrl);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

    // Convert canvas to image
    final markerAsImage = await pictureRecorder.endRecording().toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> _fetchNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final imageBytes = response.bodyBytes;
    final codec = await ui.instantiateImageCodec(imageBytes);
    final fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<ui.Image> _fetchAssetsImage(String imageUrl) async {
    final data = await rootBundle.load(imageUrl);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
    final fi = await codec.getNextFrame();
    return fi.image;
  }
}
