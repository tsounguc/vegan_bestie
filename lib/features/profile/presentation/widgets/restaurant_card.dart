import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_details.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.restaurant,
    this.onTap,
    super.key,
  });

  final RestaurantDetails restaurant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = restaurant.photos.isEmpty
        ? restaurant.icon
        : '$kImageBaseUrl${restaurant.photos[0].photoReference}&key=$kGoogleApiKey';
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // color: Colors.white,
        clipBehavior: Clip.antiAlias,
        // surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8).copyWith(top: 3),
              child: imageUrl.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        size: MediaQuery.of(context).size.width * 0.35,
                        color: Colors.white,
                      ),
                    )
                  : Ink(
                      height: MediaQuery.of(context).size.width * 0.35,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            imageUrl,
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(
                  restaurant.name.capitalizeFirstLetter(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    // color: Colors.grey.shade800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
