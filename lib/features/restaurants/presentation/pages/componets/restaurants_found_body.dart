import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

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
    return BlocListener<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantDetailsLoaded) {
          Navigator.of(context).pushNamed(
            RestaurantDetailsPage.id,
            arguments: state.restaurantDetails,
          );
        }
      },
      child: Consumer<RestaurantsNearMeProvider>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              BlocBuilder<RestaurantsBloc, RestaurantsState>(
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
                                    reviews: reviews,
                                    weekdayText: [],
                                    userPosition: userPosition,
                                    imageUrl: restaurant.photos.isEmpty
                                        ? restaurant.icon != 'empty.icon'
                                            ? restaurant.icon
                                            : ''
                                        : '$kImageBaseUrl${restaurant.photos[0].photoReference}'
                                            '&key=$kGoogleApiKey',
                                    geometry: restaurant.geometry,
                                    restaurantId: restaurant.id,
                                    restaurantName: restaurant.name.capitalizeFirstLetter(),
                                    restaurantAddress: restaurant.vicinity,
                                    restaurantPrice: r'$' * restaurant.price,
                                    isOpenNow: restaurant.openingHours.openNow,
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
            ],
          );
        },
      ),
    );
  }
}
