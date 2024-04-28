import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';

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
            title: const Text('Saved Restaurants'),
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
                    final imageUrl = restaurant.photos.isEmpty
                        ? restaurant.icon
                        : '$kImageBaseUrl${restaurant.photos[0].photoReference}&key=$kGoogleApiKey';

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
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RestaurantDetailsPage.id,
                              arguments: restaurant,
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            surfaceTintColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.025,
                                    top: MediaQuery.of(context).size.width * 0.030,
                                    bottom: MediaQuery.of(context).size.width * 0.030,
                                  ),
                                  child: Center(
                                    child: Ink(
                                      height: MediaQuery.of(context).size.width * 0.30,
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(imageUrl),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0.r),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.30,
                                                child: Text(
                                                  restaurant.name.capitalize(),
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.007,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.redAccent,
                                                    size: 12.r,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      restaurant.vicinity,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.007,
                                        ),
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: totalRestaurantRating(reviews),
                                              itemBuilder: (BuildContext context, int index) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                );
                                              },
                                              unratedColor: Colors.grey.shade400,
                                              itemSize: 15,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.025,
                                            ),
                                            Text(
                                              '${reviews.length} ${Strings.reviewsText}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IsOpenNowWidget(
                                          isOpenNow: restaurant.openingHours.openNow,
                                          weekdayText: const [],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.007,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
