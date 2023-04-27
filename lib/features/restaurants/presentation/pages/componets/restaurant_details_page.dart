import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/custom_back_button.dart';
import '../../../../../core/custom_image_widget.dart';
import '../../../../../core/error.dart';
import '../../../../../core/loading.dart';
import '../../../../../core/webviewScreen/web_view_screen.dart';
import '../../restaurant_cubit/restaurant_details_cubit.dart';
import 'package:intl/intl.dart';

import 'is_open_now.dart';

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
          // for (int index = 0; index < state.restaurantDetailsEntity!.types!.length; index++) {
          //   if (index < state.restaurantDetailsEntity!.types!.length - 1) {
          //     restaurantType = restaurantType + state.restaurantDetailsEntity!.types![index]. ?? "";
          //   }
          // }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
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
                              width: MediaQuery.of(context).size.width * 0.75,
                              // height: 35,
                              child: Text(
                                "${state.restaurantDetailsEntity?.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
                                // style: TextStyle(
                                //   color: Colors.black,
                                //   fontSize: 26,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.010,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
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
                                      width: MediaQuery.of(context).size.width * 0.01,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      child: Text(
                                        state.restaurantDetailsEntity?.formattedAddress ?? "",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                rating: state.restaurantDetailsEntity?.rating ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                unratedColor: Colors.grey.shade400,
                                itemSize: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "${state.restaurantDetailsEntity?.userRatingsTotal ?? 0} reviews",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  restaurantType,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IsOpenNowWidget(
                                visible: state.restaurantDetailsEntity?.openingHours?.openNow != null,
                                isOpenNow: state.restaurantDetailsEntity?.openingHours?.openNow != null &&
                                    state.restaurantDetailsEntity!.openingHours!.openNow!,
                                iconSize: 20,
                                fontSize: 14,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              Visibility(
                                visible: state.restaurantDetailsEntity?.openingHours?.weekdayText != null &&
                                    state.restaurantDetailsEntity!.openingHours!.openNow!,
                                maintainSize: false,
                                child: TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                                    textStyle: MaterialStatePropertyAll(
                                      TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _displayHoursDialog(context, state.restaurantDetailsEntity);
                                  },
                                  child: Text(
                                    "-  Hours",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
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
                                  Text("Call", style: TextStyle(color: Colors.black, fontSize: 14))
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
                                          Uri(
                                            scheme: 'maps',
                                            path: appleUrl,
                                          ),
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
                                  Text("Direction", style: TextStyle(color: Colors.black, fontSize: 14))
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
                                  Text("Website", style: TextStyle(color: Colors.black, fontSize: 14))
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
                        if (state.restaurantDetailsEntity?.photos != null)
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.35,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: state.restaurantDetailsEntity?.photos?.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.width * 0.30,
                                      width: MediaQuery.of(context).size.width * 0.30,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.background,
                                        // gradient:
                                        //     RadialGradient(colors: [Color(0XFF2E7D32), Colors.green.shade500]),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black45,
                                            spreadRadius: 1,
                                            blurRadius: 2.5,
                                            offset: Offset(3, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          progressIndicatorBuilder: (context, text, downloadProgress) =>
                                              LoadingPage(),
                                          fit: BoxFit.cover,
                                          imageUrl: state.restaurantDetailsEntity?.photos?[index].photoReference ==
                                                  null
                                              ? state.restaurantDetailsEntity!.icon!
                                              : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${state.restaurantDetailsEntity!.photos![index].photoReference}&key=${dotenv.env['GOOGLE_PLACES_API_KEY']}",
                                          errorWidget: (context, error, value) => Container(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.03,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 1,
                  top: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.width * 0.0,
                  child: CustomImageWidget(
                    imageUrl: state.restaurantDetailsEntity?.imageUrl,
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.01,
                    child: CustomBackButton()),
              ],
            ),
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }

  // Displays hours
  void _displayHoursDialog(BuildContext context, RestaurantDetailsEntity? restaurantDetailsEntity) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          // title: Text(
          //   'Hours',
          //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
          // ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Hours',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey.shade700, fontSize: 24),
                    ),
                  ),
                  for (int index = 0; index < restaurantDetailsEntity!.openingHours!.weekdayText!.length; index++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          restaurantDetailsEntity.openingHours!.weekdayText![index],
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
