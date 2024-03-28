import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/screens/error/error.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/screens/webview/web_view_screen.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/dine_in_takeout_delivery.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/page_view.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/rating_and_reviews_count.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RestaurantDetailsPage({
    super.key,
  });

  String restaurantType = '';

  final dateFormat = DateFormat('h:mm a');
  String openDay = '';
  int openDayObjectIndex = 0;

  Map<int, String> weekDays = {
    0: 'Sunday',
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
  };

  // var openDays = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsError) {
          return ErrorPage(
            error: state.message,
          );
        }
        if (state is RestaurantDetailsLoaded) {
          if (state.restaurantDetails.types.isNotEmpty) {
            for (var index = 0; index < state.restaurantDetails.types.length; index++) {
              if (index < state.restaurantDetails.types.length - 1) {
                restaurantType = '$restaurantType'
                    '${state.restaurantDetails.types[index]} | ';
              } else {
                restaurantType = '$restaurantType'
                    '${state.restaurantDetails.types[index]}';
              }
            }
          }
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 80,
              toolbarHeight: toolbarHeight,
              backgroundColor: Theme.of(context).colorScheme.background,
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
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.49,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.85,
                              // height: 35,
                              child: Text(
                                state.restaurantDetails.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                                size: 14,
                              ),
                              SizedBox(
                                width: MediaQuery.of(
                                      context,
                                    ).size.width *
                                    0.005,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  state.restaurantDetails.formattedAddress,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: RatingAndReviewsCountWidget(
                            rating: state.restaurantDetails.rating,
                            reviewCount: state.restaurantDetails.userRatingsTotal,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        DineInTakeoutDeliveryWidget(
                          dineIn: state.restaurantDetails.dineIn,
                          takeout: state.restaurantDetails.takeout,
                          delivery: state.restaurantDetails.delivery,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Row(
                            children: [
                              IsOpenNowWidget(
                                weekdayText: state.restaurantDetails.openingHours.weekdayText,
                                isOpenNow: state.restaurantDetails.openingHours.openNow,
                                iconSize: 20,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll(
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
                                        4,
                                      ),
                                    ),
                                    onPressed: () {
                                      launchUrl(
                                        Uri(
                                          scheme: 'tel',
                                          path: state.restaurantDetails.formattedPhoneNumber,
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      // size: 30,
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
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
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
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll(
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
                                        4,
                                      ),
                                    ),
                                    onPressed: () {
                                      final appleUrl =
                                          'https://maps.apple.com/?q=${state.restaurantDetails.name} ${state.restaurantDetails.formattedAddress}';
                                      final googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=${state.restaurantDetails.name} ${state.restaurantDetails.formattedAddress}';
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
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
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
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll(
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
                                        4,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (state.restaurantDetails.website.isNotEmpty) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => WebViewScreen(
                                              url: state.restaurantDetails.website,
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
                                      // size: 30,
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
                                      color: Colors.grey.shade800,
                                      fontSize: 14,
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
                  width: MediaQuery.of(context).size.width * 1,
                  top: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.width * 0.0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: const CustomPageView(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const LoadingPage();
        }
      },
    );
  }
}
