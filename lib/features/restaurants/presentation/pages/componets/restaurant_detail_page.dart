import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sheveegan/core/custom_image_widget.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';

import '../../../../../core/custom_back_button.dart';
import '../../../../../core/loading.dart';

class RestaurantDetailPage extends StatelessWidget {
  final RestaurantEntity? restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.73,
                        // height: 35,
                        child: Text(
                          "${restaurant?.name}",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                          // style: TextStyle(
                          //   color: Colors.black,
                          //   fontSize: 26,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                        rating: restaurant!.rating!,
                        itemBuilder: (BuildContext context, int index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        unratedColor: Colors.grey.shade400,
                        itemSize: 15,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "${restaurant!.reviewCount} reviews",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  // Visibility(
                  //   visible: restaurant?.hours[0].isOpenNow != null,
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         restaurant?.hours[0].isOpenNow != null &&
                  //                 restaurant!.hours[0].isOpenNow!
                  //             ? "Open"
                  //             : "Closed",
                  //         style: TextStyle(
                  //             color: restaurant?.hours[0].isOpenNow != null &&
                  //                     restaurant!.hours[0].isOpenNow!
                  //                 ? Colors.green
                  //                 : Colors.red,
                  //             fontSize: 12),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1,
            top: MediaQuery.of(context).size.height * 0.0,
            left: MediaQuery.of(context).size.width * 0.0,
            child: CustomImageWidget(
              imageUrl: restaurant?.imageUrl,
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 0.80,
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.01,
              child: CustomBackButton()),
        ],
      ),
    );
  }
}
