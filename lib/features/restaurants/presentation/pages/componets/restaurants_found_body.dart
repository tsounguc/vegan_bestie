import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/utils/restaurants_utils.dart';

class RestaurantsFoundBody extends StatelessWidget {
  const RestaurantsFoundBody({
    required this.restaurants,
    required this.userLocation,
    required this.markers,
    super.key,
  });

  final List<Restaurant> restaurants;

  final Position userLocation;

  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<RestaurantsCubit, RestaurantsState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (
                BuildContext context,
                BoxConstraints constraints,
              ) {
                if (state is MarkersLoaded) {
                  return SizedBox(
                    height: constraints.maxHeight,
                    child: MapPage(
                      userLocation: userLocation,
                      markers: markers,
                    ),
                  );
                }
                return SizedBox(
                  height: constraints.maxHeight,
                  child: MapPage(
                    userLocation: userLocation,
                    markers: markers,
                  ),
                );
              },
            );
          },
        ),
        DraggableScrollableSheet(
          minChildSize: 0.165,
          maxChildSize: 0.90,
          builder: (
            BuildContext context,
            ScrollController scrollController,
          ) {
            return ColoredBox(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: Divider(
                        thickness: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (restaurants.isEmpty)
                    Expanded(
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                        children: [
                          Center(
                            child: Text(
                              'No restaurants found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              "We couldn't find restaurants in your area",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, restaurantIndex) {
                          final restaurant = restaurants[restaurantIndex];
                          final isSaved = context.currentUser!.savedRestaurantsIds.contains(restaurant.id);

                          return StreamBuilder<List<RestaurantReview>>(
                            stream: RestaurantsUtils.restaurantReviewsModel(restaurant.id),
                            builder: (context, snapshot) {
                              final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];

                              final userPosition = context.read<RestaurantsNearMeProvider>().currentLocation;
                              return Column(
                                children: [
                                  HorizontalRestaurantCard(
                                    restaurant: restaurant,
                                    reviews: reviews,
                                    weekdayText: const [],
                                    userPosition: userPosition,
                                    imageUrl: restaurant.thumbnail != null &&
                                            restaurant.thumbnail != '_empty.image' &&
                                            restaurant.thumbnail!.isNotEmpty
                                        ? restaurant.thumbnail!
                                        : '',
                                    restaurantId: restaurant.id,
                                    restaurantName: restaurant.name.capitalizeFirstLetter(),
                                    restaurantAddress: '${restaurant.streetAddress}, '
                                        '${restaurant.city}, ${restaurant.state}',
                                    restaurantPrice: restaurant.price,
                                    isSaved: isSaved,
                                    fromSavedRestaurants: false,
                                  ),
                                  if (restaurantIndex == restaurants.length - 1)
                                    const SizedBox(
                                      height: 75,
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        Positioned(
          right: 15,
          bottom: 15,
          child: ElevatedButton.icon(
            // color: context.theme.primaryColor,
            style: IconButton.styleFrom(
              backgroundColor: context.theme.primaryColor,
              foregroundColor: Colors.white,
            ),

            onPressed: () {
              Navigator.of(context).pushNamed(
                AddRestaurantScreen.id,
              );
            },
            icon: const Icon(
              Icons.add,
            ),
            label: const Text(Strings.addBusinessText),
          ),
        ),
      ],
    );
  }
}
