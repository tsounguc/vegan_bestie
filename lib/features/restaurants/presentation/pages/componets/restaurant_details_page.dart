import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details_entity.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/dine_in_takeout_delivery.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/rating_and_reviews_count.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/size_config.dart';
import '../../../../../core/custom_appbar_title_widget.dart';
import '../../../../../core/custom_back_button.dart';
import '../../../../../core/custom_image_widget.dart';
import '../../../../../core/error.dart';
import '../../../../../core/loading.dart';
import '../../../../../core/vegan_bestie_logo_widget.dart';
import '../../../../../core/webviewScreen/web_view_screen.dart';
import '../../restaurant_cubit/restaurant_details_cubit.dart';
import 'package:intl/intl.dart';

import 'is_open_now.dart';
import 'page_view.dart';

class RestaurantDetailsPage extends StatelessWidget {
  String restaurantType = "";

  RestaurantDetailsPage({
    Key? key,
  }) : super(key: key);

  final dateFormat = DateFormat('h:mm a');
  String openDay = "";
  int openDayObjectIndex = 0;

  var weekDays = {
    0: "Sunday",
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
  };

  // var openDays = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
      builder: (context, state) {
        if (state is RestaurantDetailsErrorState) {
          return ErrorPage(
            error: state.error,
          );
        }
        if (state is RestaurantDetailsFoundState) {
          if (state.restaurantDetailsEntity?.types != null && state.restaurantDetailsEntity!.types!.isNotEmpty) {
            for (int index = 0; index < state.restaurantDetailsEntity!.types!.length; index++) {
              if (index < state.restaurantDetailsEntity!.types!.length - 1) {
                restaurantType = restaurantType + state.restaurantDetailsEntity!.types![index] + " | ";
              } else {
                restaurantType = restaurantType + state.restaurantDetailsEntity!.types![index];
              }
            }
          }
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 80,
              toolbarHeight: toolbarHeight,
              backgroundColor: Theme.of(context).colorScheme.background,
              automaticallyImplyLeading: true,
              leading: !Navigator.of(context).canPop()
                  ? null
                  : CustomBackButton(
                      color: Colors.black,
                    ),
              centerTitle: true,
              title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: VeganBestieLogoWidget(size: 25, fontSize: 35),
              ),
              // title: CustomAppbarTitleWidget(
              //     imageOneName: 'assets/bread.png',
              //     imageTwoName: 'assets/tomato.png'),
              // actions: [NavigationControls(controller: _controller)],
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.49,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                "${state.restaurantDetailsEntity?.name}",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                                size: 14,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.005,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  state.restaurantDetailsEntity?.formattedAddress ?? "",
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.fade),
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
                          padding: const EdgeInsets.only(left: 3.0),
                          child: RatingAndReviewsCountWidget(
                            rating: state.restaurantDetailsEntity?.rating ?? 0,
                            reviewCount: state.restaurantDetailsEntity?.userRatingsTotal ?? 0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        DineInTakeoutDeliveryWidget(
                          dineIn: state.restaurantDetailsEntity?.dineIn,
                          takeout: state.restaurantDetailsEntity?.takeout,
                          delivery: state.restaurantDetailsEntity?.delivery,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IsOpenNowWidget(
                                visible: state.restaurantDetailsEntity?.openingHours?.openNow != null,
                                weekdayText: state.restaurantDetailsEntity?.openingHours?.weekdayText ?? [],
                                isOpenNow: state.restaurantDetailsEntity?.openingHours?.openNow != null &&
                                    state.restaurantDetailsEntity!.openingHours!.openNow!,
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
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      ),
                                      elevation: MaterialStatePropertyAll(4),
                                    ),
                                    onPressed: () {
                                      launchUrl(Uri(
                                        scheme: "tel",
                                        path: state.restaurantDetailsEntity!.formattedPhoneNumber!,
                                      ));
                                    },
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      // size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Text("Call", style: TextStyle(color: Colors.grey.shade800, fontSize: 14))
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      ),
                                      elevation: MaterialStatePropertyAll(4),
                                    ),
                                    onPressed: () {
                                      String appleUrl =
                                          'https://maps.apple.com/?q=${state.restaurantDetailsEntity?.name ?? ""} ${state.restaurantDetailsEntity?.formattedAddress ?? ""}';
                                      String googleUrl =
                                          "https://www.google.com/maps/search/?api=1&query=${state.restaurantDetailsEntity?.name ?? ""} ${state.restaurantDetailsEntity?.formattedAddress ?? ""}";
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
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Text("Direction", style: TextStyle(color: Colors.grey.shade800, fontSize: 14))
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                      ),
                                      elevation: MaterialStatePropertyAll(4),
                                    ),
                                    onPressed: () {
                                      if (state.restaurantDetailsEntity?.website != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => WebViewScreen(
                                              url: state.restaurantDetailsEntity?.website,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('No Website Found')),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.launch,
                                      color: Colors.black,
                                      // size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Text("Website", style: TextStyle(color: Colors.grey.shade800, fontSize: 14))
                                ],
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.12,
                              // ),

                              // Share button
                              // Column(
                              //   children: [
                              //     Container(
                              //       decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.grey.shade700),
                              //           borderRadius: BorderRadius.circular(25)),
                              //       child: IconButton(
                              //         onPressed: () {
                              //           launchUrl(Uri.parse(
                              //             state.restaurantDetailsEntity!.url!,
                              //           ));
                              //         },
                              //         icon: Icon(
                              //           Icons.share,
                              //           color: Colors.grey.shade700,
                              //           size: 25,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: MediaQuery.of(context).size.height * 0.007,
                              //     ),
                              //     Text("Share", style: TextStyle(color: Colors.grey.shade700, fontSize: 14))
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    width: MediaQuery.of(context).size.width * 1,
                    top: MediaQuery.of(context).size.height * 0.0,
                    left: MediaQuery.of(context).size.width * 0.0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: CustomPageView(),
                    )
                    // child: CustomImageWidget(
                    //   imageUrl: state.restaurantDetailsEntity?.imageUrl,
                    // ),
                    ),
                // Positioned(
                //     top: MediaQuery.of(context).size.height * 0.05,
                //     left: MediaQuery.of(context).size.width * 0.01,
                //     child: CustomBackButton()),
              ],
            ),
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
