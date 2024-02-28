import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/utils/strings.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurant_cubit/restaurant_details_cubit.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.dietRestrictions,
    required this.restaurant,
    super.key,
  });

  final String? dietRestrictions;
  final RestaurantEntity? restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(restaurant?.id);
        BlocProvider.of<RestaurantDetailsCubit>(
          context,
        ).searchRestaurantDetails(restaurant?.id);
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
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.025,
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.030,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width * 0.030,
              ),
              child: Center(
                child: Ink(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.30,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.30,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(restaurant!.imageUrl!),
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.30,
                            child: Text(
                              restaurant!.name!,
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
                          '${(restaurant!.distance! / 1609.344).round()} '
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.007,
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
                                  restaurant!.vicinity!,
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
                          restaurant!.price ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.007,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: restaurant!.rating!,
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.025,
                        ),
                        Text(
                          '${restaurant!.reviewCount} ${Strings.reviewsText}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    IsOpenNowWidget(
                      visible: restaurant?.isOpenNow != null,
                      isOpenNow: restaurant?.isOpenNow != null && restaurant!.isOpenNow!,
                      weekdayText: const [],
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.007,
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
