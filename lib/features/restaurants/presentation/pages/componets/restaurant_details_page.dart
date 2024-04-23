import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/screens/webview/web_view_screen.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/dine_in_takeout_delivery.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/custom_page_view.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/rating_and_reviews_count.dart';
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
          20,
        ),
      ),
    ),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
    ),
    elevation: const MaterialStatePropertyAll(
      3,
    ),
  );

  void removeRestaurant(RestaurantDetails restaurantDetails, BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    String openDay = '';
    int openDayObjectIndex = 0;

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

        return Scaffold(
          appBar: AppBar(
            leadingWidth: 80,
            toolbarHeight: toolbarHeight,
            backgroundColor: Theme.of(context).colorScheme.background,
            surfaceTintColor: Colors.white,
            leading: !Navigator.of(context).canPop()
                ? null
                : const CustomBackButton(
                    color: Colors.black,
                  ),
            centerTitle: true,
            title: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: VeganBestieLogoWidget(size: 25, fontSize: 35),
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
                    restaurantDetails.placeId,
                  )
                      ? Colors.amberAccent
                      : Colors.white,
                  // size: 30,
                ),
                onPressed: () => user.savedRestaurantsIds!.contains(
                  restaurantDetails.placeId,
                )
                    ? removeRestaurant(restaurantDetails, context)
                    : saveRestaurant(restaurantDetails, context),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 5,
                                ),
                                // height: 35,
                                child: Text(
                                  restaurantDetails.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
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
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                              size: 16,
                            ),
                            SizedBox(
                              width: context.width * 0.005,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                restaurantDetails.formattedAddress,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: RatingAndReviewsCountWidget(
                          rating: restaurantDetails.rating,
                          reviewCount: restaurantDetails.userRatingsTotal,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
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
                                  child: const Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: 24,
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyle,
                                  onPressed: () {
                                    final appleUrl =
                                        'https://maps.apple.com/?q=${restaurantDetails.name} ${restaurantDetails.formattedAddress}';
                                    final googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=${restaurantDetails.name} ${restaurantDetails.formattedAddress}';
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
                                  child: const Icon(
                                    Icons.directions,
                                    color: Colors.black,
                                    size: 24,
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12,
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
                                  child: const Icon(
                                    Icons.launch,
                                    color: Colors.black,
                                    size: 24,
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
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height * 0.0,
                left: MediaQuery.of(context).size.width * 0.0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: CustomPageView(restaurantDetails: restaurantDetails),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
