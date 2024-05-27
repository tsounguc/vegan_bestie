import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/screens/webview/web_view_screen.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/custom_page_view.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/dine_in_takeout_delivery.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/rating_and_reviews_count.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/review_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RestaurantDetailsPage({
    required this.restaurantDetails,
    super.key,
  });

  final RestaurantDetails restaurantDetails;

  static const String id = '/restaurantDetailsPage';

  final dateFormat = DateFormat('h:mm a');

  final Map<int, String> weekDays = {
    0: 'Sunday',
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
  };

  final controller = ScrollController();
  final baseTextStyle = TextStyle(
    // color: Colors.grey.shade700,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );
  final elevatedButtonStyle = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(
      Colors.white,
    ),
    surfaceTintColor: const MaterialStatePropertyAll(
      Colors.white,
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
    ),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 12,
      ),
    ),
    elevation: const MaterialStatePropertyAll(
      2,
    ),
  );

  void removeRestaurant(
    RestaurantDetails restaurantDetails,
    BuildContext context,
  ) {
    BlocProvider.of<RestaurantsBloc>(
      context,
    ).add(RemoveRestaurantEvent(restaurant: restaurantDetails));
    CoreUtils.showSnackBar(
      context,
      'Restaurant removed',
    );
  }

  void saveRestaurant(RestaurantDetails product, BuildContext context) {
    BlocProvider.of<RestaurantsBloc>(
      context,
    ).add(SaveRestaurantEvent(restaurant: restaurantDetails));
    CoreUtils.showSnackBar(
      context,
      'Restaurant saved',
    );
  }

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
    final appleUrl = 'https://maps.apple.com/?q=${restaurantDetails.name}'
        ' ${restaurantDetails.formattedAddress}';
    final googleUrl = 'https://www.google.com/maps/search/?api=1&query=${restaurantDetails.name}'
        ' ${restaurantDetails.formattedAddress}';
    return StreamBuilder<UserModel>(
      stream: serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (event) => UserModel.fromMap(event.data()!),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.userProvider.user = snapshot.data;
        }
        final user = context.userProvider.user;

        return StreamBuilder<List<RestaurantReview>>(
          stream: serviceLocator<FirebaseFirestore>()
              .collection('restaurantReviews')
              .where('restaurantId', isEqualTo: restaurantDetails.id)
              // .orderBy('createdAt')
              .snapshots()
              .map(
                (event) => event.docs
                    .map(
                      (e) => RestaurantReviewModel.fromMap(e.data()),
                    )
                    .toList(),
              ),
          builder: (context, snapshot) {
            final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];
            return Scaffold(
              appBar: AppBar(
                leadingWidth: 80,
                toolbarHeight: 80,
                leading: !Navigator.of(context).canPop()
                    ? null
                    : CustomBackButton(
                        color: context.theme.iconTheme.color!,
                      ),
                centerTitle: true,
                title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const VeganBestieLogoWidget(
                    size: 25,
                    fontSize: 35,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white.withOpacity(0.7),
                    ),
                    child: Icon(
                      Icons.bookmark,
                      color: user!.savedRestaurantsIds!.contains(
                        restaurantDetails.id,
                      )
                          ? Colors.amberAccent
                          : Colors.white,
                      // size: 30,
                    ),
                    onPressed: () => user.savedRestaurantsIds!.contains(
                      restaurantDetails.id,
                    )
                        ? removeRestaurant(restaurantDetails, context)
                        : saveRestaurant(restaurantDetails, context),
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: SingleChildScrollView(
                controller: controller,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: CustomPageView(restaurantDetails: restaurantDetails),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  bottom: 5,
                                ),
                                child: Text(
                                  restaurantDetails.name.capitalizeFirstLetter(),
                                  style: baseTextStyle.copyWith(
                                    // color: Colors.grey.shade800,
                                    color: context.theme.textTheme.bodyMedium?.color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: DineInTakeoutDeliveryWidget(
                                  dineIn: restaurantDetails.dineIn,
                                  takeout: restaurantDetails.takeout,
                                  delivery: restaurantDetails.delivery,
                                ),
                              ),
                            ],
                          ),
                          IsOpenNowWidget(
                            weekdayText: restaurantDetails.openingHours.weekdayText,
                            isOpenNow: restaurantDetails.openingHours.openNow,
                            fontSize: 10.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 12,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                restaurantDetails.formattedAddress,
                                style: baseTextStyle.copyWith(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyle,
                                  onPressed: () {
                                    launchUrl(
                                      Uri(
                                        scheme: 'tel',
                                        path: restaurantDetails.formattedPhoneNumber,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.grey.shade800,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(
                                        context,
                                      ).size.height *
                                      0.01,
                                ),
                                Text(
                                  Strings.callText,
                                  style: baseTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyle,
                                  onPressed: () {
                                    if (Platform.isIOS) {
                                      launchUrl(
                                        Uri.parse(appleUrl),
                                        mode: LaunchMode.externalNonBrowserApplication,
                                      );
                                    } else {
                                      launchUrl(
                                        Uri.parse(googleUrl),
                                        mode: LaunchMode.externalNonBrowserApplication,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.directions,
                                    color: Colors.grey.shade800,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(
                                        context,
                                      ).size.height *
                                      0.01,
                                ),
                                Text(
                                  Strings.directionsText,
                                  style: baseTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyle,
                                  onPressed: () {
                                    if (restaurantDetails.website.isNotEmpty) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute<WebViewScreen>(
                                          builder: (_) => WebViewScreen(
                                            url: restaurantDetails.website,
                                          ),
                                        ),
                                      );
                                    } else {
                                      CoreUtils.showSnackBar(
                                        context,
                                        'No Website Found',
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.launch,
                                    color: Colors.grey.shade800,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(
                                        context,
                                      ).size.height *
                                      0.01,
                                ),
                                Text(
                                  Strings.websiteText,
                                  style: baseTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyle,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RestaurantReviewScreen.id,
                                      arguments: restaurantDetails,
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey.shade800,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(
                                        context,
                                      ).size.height *
                                      0.01,
                                ),
                                Text(
                                  Strings.addReview,
                                  style: baseTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Reviews',
                          style: baseTextStyle.copyWith(
                            // color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 5),
                        child: RatingAndReviewsCountWidget(
                          restaurantDetails: restaurantDetails,
                          rating: totalRestaurantRating(reviews),
                          reviewCount: reviews.length,
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (reviews.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                          child: SizedBox(
                            height: 150,
                            width: context.width * 0.75,
                            child: Text(
                              'No reviews for ${restaurantDetails.name.capitalizeFirstLetter()}'
                              '\nBe the first to leave a review!',
                              style: baseTextStyle.copyWith(
                                color: Colors.grey.shade500,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          controller: controller,
                          itemCount: reviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ReviewCard(review: reviews[index], restaurant: restaurantDetails);
                          },
                        ),
                      const SizedBox(height: 75),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
