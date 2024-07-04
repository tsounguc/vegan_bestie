import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class DataSourceUtils {
  const DataSourceUtils._();

  static void authorizeUser(FirebaseAuth auth) {
    final user = auth.currentUser;
    if (user == null) {
      throw const ServerException(
        message: 'User is not authenticated',
        statusCode: '401',
      );
    }
  }

  static GeoPoint getLesserGeoPoint(Position userLocation, double distance) {
    final lowerLat = userLocation.latitude - (kOneMileOfLat * distance);
    final lowerLng = userLocation.longitude - (kOneMileOfLng * distance);
    return GeoPoint(lowerLat, lowerLng);
  }

  static GeoPoint getGreaterGeoPoint(Position userLocation, double distance) {
    final lowerLat = userLocation.latitude + (kOneMileOfLat * distance);
    final lowerLng = userLocation.longitude + (kOneMileOfLng * distance);
    return GeoPoint(lowerLat, lowerLng);
  }
}
