import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantsUtils {
  const RestaurantsUtils._();

  static Stream<List<RestaurantReviewModel>> restaurantReviewsModel(String restaurantId) =>
      serviceLocator<FirebaseFirestore>()
          .collection('restaurantReviews')
          .where('restaurantId', isEqualTo: restaurantId)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => RestaurantReviewModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );

  static int sortByDistance(Position currentLocation, Restaurant a, Restaurant b) {
    final distanceA = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      a.geoLocation.lat,
      a.geoLocation.lng,
    );
    final distanceB = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      b.geoLocation.lat,
      b.geoLocation.lng,
    );
    return distanceA.compareTo(distanceB);
  }
}
