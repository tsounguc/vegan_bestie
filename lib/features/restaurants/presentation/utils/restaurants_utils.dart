import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';

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
}
