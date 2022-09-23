import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/presentation/webviewScreen/web_view_screen.dart';

import '../../data/models/yelp_restaurants_search_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key, required this.dietRestrictions, required this.business}) : super(key: key);

  final String? dietRestrictions;
  final Business? business;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WebViewScreen(url: business!.url),
          ),
        );

        debugPrint("${business!.name}:  ${business!.url}");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Card(
          color: Colors.green.shade50,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          child: Row(
            children: [
              business!.imageUrl!.isNotEmpty && business!.imageUrl != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Ink(
                        height: 100.r,
                        width: 100.r,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(business!.imageUrl!),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        left: 8.0.w,
                      ),
                      child: Container(
                        height: 100.r,
                        width: 100.r,
                        color: Colors.blueGrey,
                        child: Icon(
                          Icons.restaurant,
                          size: 30.r,
                          color: Colors.white,
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
                              width: 140.w,
                              child: Text(
                                business!.name!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${(business!.distance! / 1609.344).round()} mi",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.h,
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
                                    "${business!.location!.city}",
                                    style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                // Text(
                                //   !business!.isClosed! ? "Open" : "Closed",
                                //   style: TextStyle(
                                //       color: business!.isClosed! ? Colors.red : Colors.green,
                                //       fontSize: 10.sp,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          ),
                          Text(
                            "${business!.price}",
                            style: TextStyle(color: Colors.black, fontSize: 10.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.r,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBarIndicator(
                            rating: business!.rating!,
                            itemBuilder: (BuildContext context, int index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            unratedColor: Colors.grey.shade400,
                            itemSize: 15.r,
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "${business!.reviewCount} reviews",
                            style: TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              dietRestrictions!,
                              style: TextStyle(color: Colors.black, fontSize: 10.sp),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
