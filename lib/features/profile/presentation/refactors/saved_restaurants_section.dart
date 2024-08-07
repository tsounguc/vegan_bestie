import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_restaurants_pages.dart';
import 'package:sheveegan/features/profile/presentation/widgets/restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';

class SavedRestaurantsSection extends StatelessWidget {
  const SavedRestaurantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedRestaurantsProvider>(
      builder: (_, restaurantsProvider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(
                top: 5.h,
                bottom: 5.h,
              ),
              child: SectionHeader(
                sectionTitle: 'Saved Restaurants',
                seeAll: restaurantsProvider.savedRestaurantsList != null &&
                    restaurantsProvider.savedRestaurantsList!.length >= 4,
                onSeeAll: () => Navigator.of(context).pushNamed(
                  AllSavedRestaurantsPage.id,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurantsProvider.savedRestaurantsList == null
                      ? [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 45,
                              horizontal: 35,
                            ),
                            child: CircularProgressIndicator(),
                          ),
                        ]
                      : restaurantsProvider.savedRestaurantsList!.isEmpty
                          ? [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 50,
                                  horizontal: 35,
                                ),
                                child: Text(
                                  'Restaurants will be here once saved',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: context.theme.textTheme.bodySmall?.color,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ]
                          : restaurantsProvider.savedRestaurantsList!
                              .take(4)
                              .map(
                                (restaurant) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                  ),
                                  child: RestaurantCard(
                                    restaurant: restaurant,
                                    onTap: () => Navigator.of(context).pushNamed(
                                      RestaurantDetailsPage.id,
                                      arguments: restaurant,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
