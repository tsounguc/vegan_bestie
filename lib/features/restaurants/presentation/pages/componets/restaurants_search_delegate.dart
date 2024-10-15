import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/common/widgets/restaurant_vegan_status_text.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/int_extensions.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/search_restaurants_cubit/search_restaurants_cubit.dart';

class RestaurantsSearchDelegate extends SearchDelegate<List<Widget>?> {
  RestaurantsSearchDelegate(this.searchRestaurantsBloc);

  final SearchRestaurantsCubit searchRestaurantsBloc;

  @override
  String? get searchFieldLabel => Strings.searchHint;

  @override
  @override
  TextStyle? get searchFieldStyle => TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
      );

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return context.theme;
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchRestaurantsBloc.searchRestaurants(query);

    return BlocBuilder(
      bloc: searchRestaurantsBloc,
      builder: (context, state) {
        if (state is SearchingRestaurants) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchRestaurantsError) {
          return const Center(child: Text('Failed to fetch Restaurants.'));
        }

        if (state is RestaurantsSearched && state.restaurants.isEmpty) {
          return const Center(child: Text('No restaurants found.'));
        } else if (state is RestaurantsSearched && state.restaurants.isNotEmpty) {
          final filteredRestaurants = state.restaurants;
          return ListView.builder(
            itemCount: filteredRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = filteredRestaurants[index];
              final distance = context.currentLocation == null
                  ? 0
                  : Geolocator.distanceBetween(
                      context.currentLocation!.latitude,
                      context.currentLocation!.longitude,
                      restaurant.geoLocation.lat,
                      restaurant.geoLocation.lng,
                    );
              return ListTile(
                leading: restaurant.thumbnail != null
                    ? Ink(
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(restaurant.thumbnail!),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.black,
                        ),
                      ),
                title: Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          restaurant.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.streetAddress,
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          context.currentLocation == null
                              ? ''
                              : '${(distance / 1609.344).round().isLessThan} '
                                  '${Strings.distanceUnitText}',
                          style: TextStyle(
                            color: context.theme.textTheme.bodyMedium?.color,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // IsOpenNowWidget(
                        //   openHours: restaurant.openHours,
                        //   isFromDetailedPage: false,
                        //   fontSize: 9.sp,
                        // ),
                        RestaurantVeganStatusText(
                          isVegan: restaurant.veganStatus,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  // When the user taps on a suggestion, show the result
                  Navigator.of(context).pushNamed(
                    RestaurantDetailsPage.id,
                    arguments: restaurant,
                  );
                },
              );
            },
          );
        }
        return const Center(child: Text('Hello'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Optionally show suggestions (e.g., recent searches or similar queries)
    if (query.isEmpty) {
      return Center(child: Text('Type a restaurant name.'));
    } else {
      // Trigger the search action in the cubit
      searchRestaurantsBloc.searchRestaurants(query);

      return BlocBuilder(
        bloc: searchRestaurantsBloc,
        builder: (context, state) {
          if (state is SearchingRestaurants) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RestaurantsSearched) {
            final filteredRestaurants = state.restaurants;
            return ListView.builder(
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                final distance = context.currentLocation == null
                    ? 0
                    : Geolocator.distanceBetween(
                        context.currentLocation!.latitude,
                        context.currentLocation!.longitude,
                        restaurant.geoLocation.lat,
                        restaurant.geoLocation.lng,
                      );
                return ListTile(
                  leading: restaurant.thumbnail != null
                      ? Ink(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(restaurant.thumbnail!),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: const Icon(
                            Icons.restaurant,
                            color: Colors.black,
                          ),
                        ),
                  title: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: Text(
                            restaurant.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.theme.textTheme.bodyMedium?.color,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.streetAddress,
                            style: TextStyle(
                              color: context.theme.textTheme.bodyMedium?.color,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            context.currentLocation == null
                                ? ''
                                : '${(distance / 1609.344).round().isLessThan} '
                                    '${Strings.distanceUnitText}',
                            style: TextStyle(
                              color: context.theme.textTheme.bodyMedium?.color,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // IsOpenNowWidget(
                          //   openHours: restaurant.openHours,
                          //   isFromDetailedPage: false,
                          //   fontSize: 9.sp,
                          // ),
                          RestaurantVeganStatusText(
                            isVegan: restaurant.veganStatus,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    // When the user taps on a suggestion, show the result
                    Navigator.of(context).pushNamed(
                      RestaurantDetailsPage.id,
                      arguments: restaurant,
                    );
                  },
                );
              },
            );
          } else if (state is SearchRestaurantsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No suggestions available.'));
          }
        },
      );
    }
  }
}
