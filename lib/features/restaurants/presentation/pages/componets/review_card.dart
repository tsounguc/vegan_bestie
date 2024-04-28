import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.review,
    super.key,
  });

  final RestaurantReview review;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (context.currentUser?.name == review.username)
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
                          onTap: () {},
                          child: const PopupItem(
                            title: 'Edit Review',
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF757C8E),
                            ),
                          ),
                        ),
                        PopupMenuItem<void>(
                          onTap: () {},
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
              review.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              review.review,
              style: TextStyle(
                color: Colors.black,
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
