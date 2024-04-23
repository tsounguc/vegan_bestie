import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
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
    return BlocListener<RestaurantsBloc, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantDetailsLoaded) {
          Navigator.of(context).pushNamed(
            RestaurantDetailsPage.id,
            arguments: state.restaurantDetails,
          );
        }
      },
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              return SizedBox(
                height: constraints.maxHeight,
                child: MapPage(
                  userLocation: userLocation,
                  markers: markers,
                ),
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
                        width: 50,
                        height: 25,
                        child: Divider(
                          thickness: 5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: restaurants.length,
                        itemBuilder: (context, restaurantIndex) {
                          return HorizontalRestaurantCard(
                            restaurant: restaurants[restaurantIndex],
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
      ),
    );
  }
}
