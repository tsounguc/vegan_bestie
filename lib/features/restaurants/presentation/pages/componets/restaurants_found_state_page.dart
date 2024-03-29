import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_card.dart';

import '../../restaurants_bloc/restaurants_bloc.dart';
import '../map_page.dart';

class RestaurantsFoundStatePage extends StatelessWidget {
  const RestaurantsFoundStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsFoundState) {
          return Stack(
            children: [
              LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: MapPage(),
                );
              }),
              DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.165,
                  maxChildSize: 0.90,
                  expand: true,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            physics: ClampingScrollPhysics(),
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
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.restaurants.length,
                              itemBuilder: (context, restaurantIndex) {
                                String? dietRestrictions = "";
                                return RestaurantCard(
                                  dietRestrictions: dietRestrictions,
                                  restaurant: state.restaurants[restaurantIndex],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        }
        return Container();
      },
    );
  }
}
