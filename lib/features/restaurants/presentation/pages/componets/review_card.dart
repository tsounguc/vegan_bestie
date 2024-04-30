import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/edit_restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.review,
    required this.restaurant,
    super.key,
  });

  final RestaurantReview review;
  final RestaurantDetails restaurant;

  void deleteReview(BuildContext context, RestaurantReview review) {
    BlocProvider.of<RestaurantsBloc>(
      context,
    ).add(DeleteRestaurantReviewEvent(review: review));
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
    var timestamp = '${DateFormat('MMM d, yyyy').format(review.createdAt.toLocal())}';
    if (review.updatedAt.toLocal().isAfter(review.createdAt.toLocal())) {
      timestamp = 'Edited ${DateFormat('MMM d, yyyy').format(review.updatedAt.toLocal())}';
      debugPrint('Updated $timestamp');
    }
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: review.userProfilePic.isEmpty || review.userProfilePic == kDefaultAvatar
                          ? null
                          : NetworkImage(review.userProfilePic),
                      child: review.userProfilePic.isNotEmpty && review.userProfilePic != kDefaultAvatar
                          ? null
                          : const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      review.username,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (context.currentUser?.uid == review.userId)
                  PopupMenuButton(
                    elevation: 1,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_horiz_outlined),
                    surfaceTintColor: Colors.white,
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
                          child: const PopupItem(
                            title: 'Edit Review',
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF757C8E),
                            ),
                          ),
                        ),
                        PopupMenuItem<void>(
                          onTap: () => deleteReview(context, review),
                          child: const PopupItem(
                            title: 'Delete Review',
                            icon: Icon(
                              Icons.delete,
                              color: Color(0xFF757C8E),
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
                Text(
                  review.title.capitalize(),
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  timestamp,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
            const SizedBox(height: 5),
            Text(
              review.review,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
