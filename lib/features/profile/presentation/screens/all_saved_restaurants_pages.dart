import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class AllSavedRestaurantsPage extends StatelessWidget {
  const AllSavedRestaurantsPage({super.key});

  static const String id = '/allSavedRestaurantsPage';

  double totalRestaurantRating(List<RestaurantReview> reviews) {
    var count = 0;
    var rating = 0.0;

    for (final review in reviews) {
      count += 1;
      rating += (review.rating - rating) / count;
    }

    return rating;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Consumer<SavedRestaurantsProvider>(
      builder: (_, restaurantsProvider, __) {
        final restaurantsList = restaurantsProvider.savedRestaurantsList ?? <RestaurantDetails>[];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Colors.white,
            leading: const CustomBackButton(
              color: Colors.black,
            ),
            title: Text(
              'Saved Restaurants',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                // fontSize: 24,
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height * 0.00),
                ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: restaurantsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final restaurant = restaurantsList[index];
                    return StreamBuilder<List<RestaurantReview>>(
                      stream: serviceLocator<FirebaseFirestore>()
                          .collection('restaurantReviews')
                          .where('restaurantId', isEqualTo: restaurant.id)
                          .snapshots()
                          .map(
                            (event) => event.docs
                                .map(
                                  (e) => RestaurantReviewModel.fromMap(
                                    e.data(),
                                  ),
                                )
                                .toList(),
                          ),
                      builder: (context, snapshot) {
                        final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];
                        final userPosition = context.read<RestaurantsBloc>().currentLocation;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RestaurantDetailsPage.id,
                              arguments: restaurant,
                            );
                          },
                          child: HorizontalRestaurantCard(
                            fromSavedRestaurants: true,
                            reviews: reviews,
                            weekdayText: const [],
                            userPosition: userPosition,
                            imageUrl: restaurant.photos.isEmpty
                                ? restaurant.icon
                                : '$kImageBaseUrl${restaurant.photos[0].photoReference}'
                                    '&key=$kGoogleApiKey',
                            geometry: restaurant.geometry,
                            restaurantId: restaurant.id,
                            restaurantName: restaurant.name.capitalizeFirstLetter(),
                            restaurantAddress: restaurant.vicinity,
                            restaurantPrice: '',
                            isOpenNow: restaurant.openingHours.openNow,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: context.height * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
