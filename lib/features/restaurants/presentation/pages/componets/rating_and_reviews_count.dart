import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              itemSize: 20,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              '${rating.toStringAsPrecision(2)} out of 5',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '$reviewCount review'.pluralize(reviewCount, ending: 's'),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
