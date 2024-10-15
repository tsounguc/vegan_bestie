import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/core/common/app/providers/theme_inherited_widget.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurants_search_delegate.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/search_restaurants_cubit/search_restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/utils/restaurants_utils.dart';
import 'package:sheveegan/themes/app_theme.dart';

//ignore: must_be_immutable
class RestaurantsFoundBody extends StatefulWidget {
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
  State<RestaurantsFoundBody> createState() => _RestaurantsFoundBodyState();
}

class _RestaurantsFoundBodyState extends State<RestaurantsFoundBody> {
  final _scrollThreshold = 0.75;

  Widget mapView = const LoadingPage();

  Widget currentListView = const SliverToBoxAdapter();

  final themeMode = ThemeModePreference();

  List<String> categories = [
    'Vegan',
    'Vegan options',
    'Takeout',
    'Dine-in',
    'Delivery',
  ];

  List<String> selectedCategories = [];

  //the initState will allow us to add our scroll listener and initialize the BloC
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<SearchRestaurantsCubit>(),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              return SizedBox(
                height: constraints.maxHeight,
                child: BlocConsumer<RestaurantsCubit, RestaurantsState>(
                  builder: (context, state) {
                    if (state is RestaurantsInitial) {
                      return mapView = MapPage(
                        userLocation: context.currentLocation ??
                            Position(
                              longitude: 0,
                              latitude: 0,
                              timestamp: DateTime.now(),
                              accuracy: 0,
                              altitude: 0,
                              altitudeAccuracy: 0,
                              heading: 0,
                              headingAccuracy: 0,
                              speed: 0,
                              speedAccuracy: 0,
                            ),
                        markers: buildMarkersSet(buildList(context), context.markers ?? {}),
                      );
                    } else if (state is RestaurantsLoaded) {
                      return mapView = MapPage(
                        userLocation: context.currentLocation ??
                            Position(
                              longitude: 0,
                              latitude: 0,
                              timestamp: DateTime.now(),
                              accuracy: 0,
                              altitude: 0,
                              altitudeAccuracy: 0,
                              heading: 0,
                              headingAccuracy: 0,
                              speed: 0,
                              speedAccuracy: 0,
                            ),
                        markers: buildMarkersSet(buildList(context), state.markers),
                      );
                    } else {
                      return mapView = MapPage(
                        userLocation: context.currentLocation ??
                            Position(
                              longitude: 0,
                              latitude: 0,
                              timestamp: DateTime.now(),
                              accuracy: 0,
                              altitude: 0,
                              altitudeAccuracy: 0,
                              heading: 0,
                              headingAccuracy: 0,
                              speed: 0,
                              speedAccuracy: 0,
                            ),
                        markers: buildMarkersSet(buildList(context), context.markers ?? {}),
                      );
                    }
                  },
                  listener: (BuildContext context, RestaurantsState state) {
                    if (state is LoadingRestaurants) {
                      // CoreUtils.showLoadingDialog(context);
                    }
                  },
                ),
              );
            },
          ),
          DraggableScrollableSheet(
            key: UniqueKey(),
            minChildSize: 0.05,
            maxChildSize: 0.80,
            controller: DraggableScrollableController(),
            builder: (
              BuildContext context,
              ScrollController draggableScrollController,
            ) {
              return ColoredBox(
                color: context.theme.colorScheme.background,
                child: CustomScrollView(
                  key: UniqueKey(),
                  controller: draggableScrollController
                    ..addListener(
                      () => _onScroll(context, draggableScrollController),
                    ),
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 80,
                      title: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Divider(
                                thickness: 5,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: categories
                                    .map(
                                      (category) => Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: FilterChip(
                                          label: Text(
                                            category,
                                            style: TextStyle(
                                                color: selectedCategories.contains(category)
                                                    ? Colors.white
                                                    : context.theme.textTheme.bodyMedium?.color,
                                                fontWeight: selectedCategories.contains(category)
                                                    ? FontWeight.w600
                                                    : FontWeight.normal),
                                          ),
                                          selected: selectedCategories.contains(category),
                                          selectedColor: context.theme.primaryColor,
                                          checkmarkColor: Colors.white,
                                          elevation: selectedCategories.contains(category) ? 0 : 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            side: BorderSide(
                                                color: selectedCategories.contains(category)
                                                    ? Colors.transparent
                                                    : Colors.grey.shade400),
                                          ),
                                          backgroundColor: context.theme.cardTheme.color,
                                          // color: selectedCategories.contains(category)
                                          //     ? MaterialStatePropertyAll(context.theme.primaryColor.withOpacity(0.2))
                                          //     : MaterialStatePropertyAll(context.theme.cardColor),
                                          onSelected: (selected) {
                                            setState(() {
                                              if (selected) {
                                                selectedCategories.add(category);
                                              } else {
                                                selectedCategories.remove(category);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      primary: false,
                      pinned: true,
                      centerTitle: true,
                    ),
                    const SliverToBoxAdapter(),
                    BlocBuilder<RestaurantsCubit, RestaurantsState>(
                      builder: (context, state) {
                        if (state is LoadingRestaurants || state is RestaurantsInitial) {
                          return currentListView = SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 75),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Loading...',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppTheme.lightPrimaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const CircularProgressIndicator(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (state is RestaurantsError) {
                          return currentListView = SliverToBoxAdapter(
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        } else {
                          if (context.restaurants != null && context.restaurants!.isNotEmpty) {
                            final sortedRestaurants = buildList(context)
                              ..sort(
                                (a, b) => RestaurantsUtils.sortByDistance(context.currentLocation!, a, b),
                              );
                            return currentListView = SliverList.builder(
                              itemCount:
                                  context.hasReachedEnd ? sortedRestaurants.length : sortedRestaurants.length + 1,
                              itemBuilder: (context, restaurantIndex) {
                                if (restaurantIndex >= sortedRestaurants.length &&
                                    state is RestaurantsLoaded &&
                                    !state.hasReachedEnd) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Loading more...',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppTheme.lightPrimaryColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const CircularProgressIndicator(),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                final restaurant = sortedRestaurants[restaurantIndex];
                                final isSaved = context.currentUser?.savedRestaurantsIds.contains(restaurant.id);

                                return StreamBuilder<List<RestaurantReview>>(
                                  stream: RestaurantsUtils.restaurantReviewsModel(restaurant.id),
                                  builder: (context, snapshot) {
                                    final reviews = snapshot.hasData ? snapshot.data! : <RestaurantReview>[];

                                    final userPosition = context.currentLocation;
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
                                          isSaved: isSaved ?? false,
                                          fromSavedRestaurants: false,
                                        ),
                                        if (restaurantIndex == context.restaurants!.length - 1)
                                          const SizedBox(
                                            height: 50,
                                          ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return currentListView = SliverList.list(
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
                                    "We couldn't find restaurants in your area\n",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      },
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
          Positioned(
            top: 20,
            left: 50,
            right: 50,
            child: SizedBox(
              // height: 50,
              width: 200.w,
              child: Builder(
                builder: (context) {
                  return IField(
                    controller: TextEditingController(),
                    readOnly: true,
                    filled: true,
                    fillColor: context.theme.colorScheme.background.withOpacity(0.5),
                    focusColor: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.theme.iconTheme.color?.withOpacity(0.6),
                    ),
                    hintStyle: TextStyle(
                      color: context.theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.6,
                      ),
                    ),
                    hintText: Strings.searchHint,
                    onTap: () async {
                      await showSearch(
                        context: context,
                        delegate: RestaurantsSearchDelegate(serviceLocator<SearchRestaurantsCubit>()),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> buildMarkersSet(List<Restaurant> sortedRestaurants, Set<Marker> markers) {
    final restaurantsNames = <String>[];
    for (final restaurant in sortedRestaurants) {
      restaurantsNames.add(restaurant.name);
    }
    final restaurantsMarkers = markers.where((marker) => restaurantsNames.contains(marker.mapsId.value)).toSet();
    return restaurantsMarkers;
  }

  List<Restaurant> buildList(BuildContext context) {
    return context.restaurants?.where((restaurant) {
          final isVegan = selectedCategories.contains('Vegan') && restaurant.veganStatus == true;
          final hasVeganOptions =
              selectedCategories.contains('Vegan options') && restaurant.hasVeganOptions == true;
          final takeout = selectedCategories.contains('Takeout') && restaurant.takeout;
          final dineIn = selectedCategories.contains('Dine-in') && restaurant.dineIn;
          final delivery = selectedCategories.contains('Delivery') && restaurant.delivery;
          final nonSelected = selectedCategories.isEmpty;
          return nonSelected ||
              isVegan ||
              hasVeganOptions ||
              (isVegan && !hasVeganOptions && (takeout || dineIn || delivery)) ||
              (!isVegan && hasVeganOptions && (takeout || dineIn || delivery));
        }).toList() ??
        [];
  }

  void _onScroll(BuildContext context, ScrollController controller) {
    //if the bottom of the list is reached, request a new page
    if (controller.position.pixels >= controller.position.maxScrollExtent * _scrollThreshold) {
      final cubit = BlocProvider.of<RestaurantsCubit>(context);
      if (cubit.state is RestaurantsLoaded) {
        debugPrint('_isBottom');
        cubit.loadMoreRestaurants(
          context.currentLocation!,
          context.radius,
        );
      }
    }
  }
}
