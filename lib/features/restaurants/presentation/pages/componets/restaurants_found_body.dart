import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

import '../add_restaurant_screen.dart';

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
    final scrollController = ScrollController();
    return BlocListener<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantDetailsLoaded) {
          // Navigator.of(context).pushNamed(
          //   RestaurantDetailsPage.id,
          //   arguments: state.restaurant,
          // );
        }
      },
      child: Consumer<RestaurantsNearMeProvider>(
        builder: (context, controller, child) {
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
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: restaurants.length,
                            itemBuilder: (context, restaurantIndex) {
                              return StreamBuilder<List<RestaurantReview>>(
                                stream: serviceLocator<FirebaseFirestore>()
                                    .collection('restaurantReviews')
                                    .where('restaurantId', isEqualTo: restaurants[restaurantIndex].id)
                                    .snapshots()
                                    .map(
                                      (event) => event.docs
                                          .map(
                                            (e) => RestaurantReviewModel.fromMap(
                                              e.data(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                builder: (context, snapshot) {
                                  final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];
                                  final restaurant = restaurants[restaurantIndex];
                                  final userPosition = context.read<RestaurantsNearMeProvider>().currentLocation;
                                  return HorizontalRestaurantCard(
                                    restaurant: restaurant,
                                    reviews: reviews,
                                    weekdayText: [],
                                    userPosition: userPosition,
                                    imageUrl: restaurant.photos.isEmpty || restaurant.photos[0] == '_empty.photo1'
                                        ? restaurant.image != null &&
                                                restaurant.image != '_empty.image' &&
                                                restaurant.image!.isNotEmpty
                                            ? restaurant.image!
                                            : ''
                                        : restaurant.photos[0],
                                    // geometry: restaurant.geometry,
                                    restaurantId: restaurant.id,
                                    restaurantName: restaurant.name.capitalizeFirstLetter(),
                                    restaurantAddress: '${restaurant.streetAddress}, '
                                        '${restaurant.city}',
                                    restaurantPrice: r'$' * 3,
                                    isOpenNow: true,
                                    //restaurant.openingHours.openNow,
                                    fromSavedRestaurants: false,
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
                    // BlocProvider.of<RestaurantsBloc>(context).add(
                    //   const AddRestaurantEvent(
                    //     restaurant: Restaurant.empty(),
                    //   ),
                    // );

                    Navigator.of(context).pushNamed(
                      AddRestaurantScreen.id,
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(Strings.addBusinessText),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
