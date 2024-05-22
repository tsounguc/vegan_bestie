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
      // child: Scaffold(
      //   extendBody: true,
      //   body: CustomScrollView(
      //     controller: scrollController,
      //     shrinkWrap: true,
      //     slivers: [
      //       SliverAppBar(
      //         expandedHeight: context.height * 0.55,
      //         backgroundColor: Colors.white,
      //         surfaceTintColor: Colors.white,
      //         pinned: true,
      //         // snap: true,
      //         flexibleSpace: FlexibleSpaceBar(
      //           background: Stack(
      //             children: [
      //               Positioned.fill(
      //                 child: LayoutBuilder(
      //                   builder: (
      //                     BuildContext context,
      //                     BoxConstraints constraints,
      //                   ) {
      //                     return SizedBox(
      //                       height: constraints.maxHeight,
      //                       child: MapPage(
      //                         userLocation: userLocation,
      //                         markers: markers,
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         bottom: PreferredSize(
      //           preferredSize: const Size.fromHeight(100),
      //           child: Container(
      //             width: double.maxFinite,
      //             decoration: const BoxDecoration(
      //               color: Colors.white,
      //             ),
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   width: 50,
      //                   height: 25,
      //                   child: Divider(
      //                     thickness: 5,
      //                     color: Theme.of(context).primaryColor,
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 15),
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         'Distance',
      //                         style: TextStyle(color: Colors.grey.shade800),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Consumer<RestaurantsNearMeProvider>(
      //                   builder: (context, controller, child) {
      //                     return SizedBox(
      //                       height: 60,
      //                       child: ListView.builder(
      //                         scrollDirection: Axis.horizontal,
      //                         controller: scrollController,
      //                         physics: const AlwaysScrollableScrollPhysics(),
      //                         shrinkWrap: true,
      //                         itemCount: 5,
      //                         itemBuilder: (context, int index) {
      //                           return Padding(
      //                             padding: const EdgeInsets.symmetric(
      //                               horizontal: 8,
      //                               vertical: 10,
      //                             ),
      //                             child: ElevatedButton(
      //                               style: ElevatedButton.styleFrom(
      //                                 surfaceTintColor: Colors.white,
      //                                 elevation: 2,
      //                                 disabledBackgroundColor: context.theme.primaryColor,
      //                                 disabledForegroundColor: Colors.white,
      //                               ),
      //                               onPressed: controller.selectedDistanceButton == index
      //                                   ? null
      //                                   : () {
      //                                       controller.changeSelectedButton(index);
      //                                       double numberOfMiles = 1.0 + index + index * index;
      //                                       controller.setRadius(
      //                                         numberOfMiles * kOneMile,
      //                                       );
      //
      //                                       BlocProvider.of<RestaurantsBloc>(context).add(
      //                                         GetRestaurantsEvent(
      //                                           position: context.read<RestaurantsBloc>().currentLocation!,
      //                                           radius: controller.radius,
      //                                         ),
      //                                       );
      //                                     },
      //                               child: Text(
      //                                 '${1 + index + index * index} mile${index <= 1 ? '' : 's'}',
      //                                 style: TextStyle(
      //                                   fontSize: 10.sp,
      //                                   fontWeight: FontWeight.w600,
      //                                 ),
      //                               ),
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       SliverToBoxAdapter(
      //         child: Column(
      //           children: [
      //             ListView.builder(
      //               controller: scrollController,
      //               physics: const ClampingScrollPhysics(),
      //               shrinkWrap: true,
      //               itemCount: restaurants.length,
      //               itemBuilder: (context, restaurantIndex) {
      //                 return StreamBuilder<List<RestaurantReview>>(
      //                   stream: serviceLocator<FirebaseFirestore>()
      //                       .collection('restaurantReviews')
      //                       .where('restaurantId', isEqualTo: restaurants[restaurantIndex].id)
      //                       .snapshots()
      //                       .map(
      //                         (event) => event.docs
      //                             .map(
      //                               (e) => RestaurantReviewModel.fromMap(
      //                                 e.data(),
      //                               ),
      //                             )
      //                             .toList(),
      //                       ),
      //                   builder: (context, snapshot) {
      //                     final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];
      //                     final restaurant = restaurants[restaurantIndex];
      //                     final userPosition = context.read<RestaurantsBloc>().currentLocation;
      //                     return HorizontalRestaurantCard(
      //                       reviews: reviews,
      //                       weekdayText: [],
      //                       userPosition: userPosition,
      //                       imageUrl: restaurant.photos.isEmpty
      //                           ? restaurant.icon
      //                           : '$kImageBaseUrl${restaurant.photos[0].photoReference}'
      //                               '&key=$kGoogleApiKey',
      //                       geometry: restaurant.geometry,
      //                       restaurantId: restaurant.id,
      //                       restaurantName: restaurant.name.capitalizeFirstLetter(),
      //                       restaurantAddress: restaurant.vicinity,
      //                       restaurantPrice: r'$' * restaurant.price,
      //                       isOpenNow: restaurant.openingHours.openNow,
      //                       fromSavedRestaurants: false,
      //                     );
      //                   },
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
                initialChildSize: 0.6,
                minChildSize: 0.27,
                maxChildSize: 0.95,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Radius'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ).copyWith(top: 10, left: 35),
                          child: const SizedBox(
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('1 mi'), Text('15 mi')],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Slider(
                            label: '${controller.sliderValue.round()}',
                            min: 1,
                            max: 15,
                            value: controller.sliderValue,
                            divisions: 15,
                            onChanged: (value) {
                              controller.sliderValue = value;
                            },
                            onChangeEnd: (value) {
                              if (controller.sliderValue * kOneMile != controller.radius) {
                                controller.radius = value * kOneMile;

                                BlocProvider.of<RestaurantsBloc>(context).add(
                                  GetRestaurantsEvent(
                                    position: context.read<RestaurantsBloc>().currentLocation!,
                                    radius: controller.radius,
                                  ),
                                );
                              }
                            },
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
                                  final userPosition = context.read<RestaurantsBloc>().currentLocation;
                                  return HorizontalRestaurantCard(
                                    reviews: reviews,
                                    weekdayText: [],
                                    userPosition: userPosition,
                                    imageUrl: restaurant.photos.isEmpty
                                        ? restaurant.icon
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
