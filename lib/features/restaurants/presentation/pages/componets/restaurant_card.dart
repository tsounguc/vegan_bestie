import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.restaurant,
    super.key,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final imageUrl = restaurant.photos.isEmpty
        ? restaurant.icon
        : '$kImageBaseUrl${restaurant.photos[0].photoReference}&key=$kGoogleApiKey';
    final position = context.read<RestaurantsBloc>().currentLocation!;

    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      restaurant.geometry.location.lat,
      restaurant.geometry.location.lng,
    );
    return GestureDetector(
      onTap: () {
        debugPrint(restaurant.id);
        BlocProvider.of<RestaurantsBloc>(
          context,
        ).add(GetRestaurantDetailsEvent(id: restaurant.id));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsPage(),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
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
                              restaurant.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${(distance / 1609.344).round()} '
                          '${Strings.distanceUnitText}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
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
                        Text(
                          restaurant.price,
                          style: TextStyle(
                            color: Colors.black,
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
                          rating: restaurant.rating,
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
                          '${restaurant.reviewCount} ${Strings.reviewsText}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    IsOpenNowWidget(
                      isOpenNow: restaurant.openingHours.openNow,
                      weekdayText: restaurant.openingHours.weekdayText,
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
