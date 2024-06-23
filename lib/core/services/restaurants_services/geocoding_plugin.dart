import 'package:geocoding/geocoding.dart';

class GeocodingPlugin {
  Future<Location> getCoordinateFromAddress(String address) async {
    final locations = await locationFromAddress(address);
    final geoPoint = locations[0];
    return geoPoint;
  }

  Future<Placemark> getPlaceMarkFromPosition({
    required double latitude,
    required double longitude,
  }) async {
    final placeMarks = await placemarkFromCoordinates(latitude, longitude);
    final placeMark = placeMarks[0];
    return placeMark;
  }
}
