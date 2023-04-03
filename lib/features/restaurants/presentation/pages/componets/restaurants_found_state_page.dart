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
                return SizedBox(height: constraints.maxHeight, child: MapPage());
              }),
              DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.07,
                  maxChildSize: 0.90,
                  expand: true,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 25,
                            child: Divider(
                              thickness: 5,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: state.restaurants.length,
                              itemBuilder: (context, restaurantIndex) {
                                int? length = state.restaurants[restaurantIndex].categories?.length;
                                String? dietRestrictions = "";
                                for (int categoryIndex = 0; categoryIndex < length!; categoryIndex++) {
                                  dietRestrictions = dietRestrictions! +
                                      "${state.restaurants[restaurantIndex].categories?[categoryIndex].title}";
                                  if (categoryIndex < length - 1) {
                                    dietRestrictions = dietRestrictions + " | ";
                                  }
                                }
                                return RestaurantCard(
                                  dietRestrictions: dietRestrictions,
                                  business: state.restaurants[restaurantIndex],
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
