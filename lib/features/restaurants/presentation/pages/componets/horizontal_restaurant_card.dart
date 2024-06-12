import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/common/entities/restaurant_entities.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class HorizontalRestaurantCard extends StatelessWidget {
  const HorizontalRestaurantCard({
    required this.reviews,
    required this.weekdayText,
    required this.userPosition,
    required this.imageUrl,
    // required this.geometry,
    required this.restaurantId,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantPrice,
    required this.isOpenNow,
    required this.fromSavedRestaurants,
    super.key,
  });

  final bool fromSavedRestaurants;
  final List<RestaurantReview> reviews;
  final String imageUrl;

  // final Geometry geometry;
  final String restaurantId;
  final String restaurantName;
  final String restaurantAddress;
  final String restaurantPrice;
  final bool isOpenNow;
  final List<String> weekdayText;
  final Position? userPosition;

  double totalRestaurantRating() {
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
    final distance = 0.0;
    // Geolocator.distanceBetween(
    //   userPosition?.latitude ?? 0,
    //   userPosition?.longitude ?? 0,
    //   geometry.location.lat,
    //   geometry.location.lng,
    // );
    return GestureDetector(
      onTap: fromSavedRestaurants
          ? null
          : () {
              debugPrint(restaurantId);
              BlocProvider.of<RestaurantsBloc>(
                context,
              ).add(GetRestaurantDetailsEvent(id: restaurantId));
            },
      child: Card(
        // color: Colors.white,
        clipBehavior: Clip.antiAlias,
        // surfaceTintColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
                top: MediaQuery.of(context).size.width * 0.025,
                bottom: MediaQuery.of(context).size.width * 0.025,
              ),
              child: Center(
                child: imageUrl.isNotEmpty
                    ? Ink(
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
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.width * 0.30,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: const Icon(Icons.restaurant),
                      ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10.0.r),
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
                              restaurantName,
                              style: TextStyle(
                                fontSize: 12.sp,
                                // color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          fromSavedRestaurants
                              ? ''
                              : '${(distance / 1609.344).round()} '
                                  '${Strings.distanceUnitText}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: context.width * 0.5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                                size: 12.r,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Flexible(
                                child: Text(
                                  restaurantAddress,
                                  style: TextStyle(
                                    color: context.theme.textTheme.bodySmall?.color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          restaurantPrice,
                          style: TextStyle(
                            // color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
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
                          rating: totalRestaurantRating(),
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
                          style: TextStyle(
                            // color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    IsOpenNowWidget(
                      isOpenNow: isOpenNow,
                      weekdayText: weekdayText,
                      fontSize: 10.sp,
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
  }
}
