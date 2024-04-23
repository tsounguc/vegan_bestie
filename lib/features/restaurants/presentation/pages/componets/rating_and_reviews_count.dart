import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingAndReviewsCountWidget extends StatelessWidget {
  const RatingAndReviewsCountWidget({
    required this.rating,
    required this.reviewCount,
    super.key,
  });

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (BuildContext context, int index) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
            );
          },
          unratedColor: Colors.grey.shade400,
          itemSize: 16,
        ),
        const SizedBox(
          width: 7,
        ),
        Text(
          '$reviewCount Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
