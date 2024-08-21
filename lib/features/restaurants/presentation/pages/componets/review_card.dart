import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/date_time_extensions.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/edit_restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.review,
    required this.restaurant,
    super.key,
  });

  final RestaurantReview review;
  final Restaurant restaurant;

  void deleteReview(BuildContext context, RestaurantReview review) {
    BlocProvider.of<RestaurantsCubit>(
      context,
    ).deleteReview(review);
  }

  void editReview(BuildContext context, RestaurantReview review) {
    Navigator.pushNamed(
      context,
      EditRestaurantReviewScreen.id,
      arguments: EditRestaurantScreenArguments(review, restaurant),
    );
  }

  @override
  Widget build(BuildContext context) {
    var timestamp = review.createdAt.timeAgo;
    // DateFormat('MMM d, yyyy').format(review.createdAt.toLocal());
    if (review.updatedAt.toLocal().isAfter(review.createdAt.toLocal())) {
      timestamp = 'Edited ' + review.updatedAt.timeAgo;
      // 'Edited ${DateFormat('MMM d, yyyy').format(review.updatedAt.toLocal())}';
    }

    return StreamBuilder<List<UserModel>>(
      stream: DashboardUtils.getUser(review.userId),
      builder: (context, snapshot) {
        UserModel? user;
        if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
          user = snapshot.data!.first;
        }

        final image = Image.network(
          user?.photoUrl ?? '',
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person_outline,
              color: Colors.white,
            );
          },
        );

        image.image.resolve(ImageConfiguration.empty).addListener(
              ImageStreamListener(
                (_, __) {
                  /* You can do something when the image is loaded. */
                },
                onError: (_, __) {
                  // Evict the object from the cache to retry to fetch it the next
                  // time this widget is built.
                  imageCache.evict(image.image);
                },
              ),
            );
        return Card(
          // surfaceTintColor: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ).copyWith(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              user == null || user.photoUrl == null || user.photoUrl!.isEmpty ? null : image.image,
                          child: user != null && user.photoUrl != null && user.photoUrl!.isNotEmpty
                              ? null
                              : const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 165.w,
                          child: Text(
                            user?.name ?? 'Anonymous User',
                            style: TextStyle(
                              // color: Colors.grey.shade800,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (context.currentUser?.uid == review.userId)
                      PopupMenuButton(
                        elevation: 1,
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.more_horiz_outlined,
                          size: 16.r,
                        ),
                        surfaceTintColor: context.theme.cardTheme.color,
                        color: context.theme.cardTheme.color,
                        offset: const Offset(35, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<void>(
                              onTap: () => editReview(
                                context,
                                review,
                              ),
                              child: PopupItem(
                                title: 'Edit Review',
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: context.theme.iconTheme.color,
                                ),
                              ),
                            ),
                            PopupMenuItem<void>(
                              onTap: () => deleteReview(context, review),
                              child: PopupItem(
                                title: 'Delete Review',
                                icon: Icon(
                                  Icons.delete,
                                  color: context.theme.iconTheme.color,
                                ),
                              ),
                            ),
                          ];
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        review.title.capitalizeFirstLetter(),
                        style: TextStyle(
                          // color: Colors.grey.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Text(
                    //   timestamp,
                    //   style: TextStyle(
                    //     color: context.theme.textTheme.bodySmall?.color,
                    //     fontSize: 10.sp,
                    //     fontWeight: FontWeight.normal,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 5),
                RatingBarIndicator(
                  rating: review.rating,
                  itemBuilder: (BuildContext context, int index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  unratedColor: Colors.grey.shade400,
                  itemSize: 16,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    review.text,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.grey.shade700),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      timestamp,
                      style: TextStyle(
                        color: context.theme.textTheme.bodySmall?.color,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
