import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/loading.dart';
import '../geolocation_bloc/geolocation_bloc.dart';
import 'componets/restaurant_card.dart';
import '../restaurants_bloc/restaurants_bloc.dart';

class RestaurantsHomePage extends StatelessWidget {
  static const String id = "/restaurantsHomepage";
  const RestaurantsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    // BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent());
    return BlocListener<GeolocationBloc, GeolocationState>(
      listener: (context, state) {
        if (state is GeolocationLoadedState) {
          BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent(position: state.position));
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(buildContext).requestFocus(new FocusNode());
        },
        child: BlocBuilder<RestaurantsBloc, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsFoundState) {
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: ListView.builder(
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
              );
            } else {
              return LoadingPage();
              // return Scaffold(
              //   backgroundColor: Theme.of(context).colorScheme.background,
              //   body: Container(
              //     padding: EdgeInsets.only(top: 56.h, right: 16.w, bottom: 8.h, left: 16.w),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           width: double.infinity,
              //           height: 40.h,
              //           decoration: BoxDecoration(
              //             color: Colors.green.shade50,
              //             borderRadius: BorderRadius.circular(5.r),
              //           ),
              //           child: Center(
              //             child: TextField(
              //               decoration: InputDecoration(
              //                 prefixIcon: Icon(
              //                   Icons.search,
              //                   color: Theme.of(context).colorScheme.background,
              //                 ),
              //                 // suffixIcon: IconButton(
              //                 //   icon: Icon(
              //                 //     Icons.cancel,
              //                 //     color: Theme.of(context).backgroundColor,
              //                 //   ),
              //                 //   onPressed: () {},
              //                 // ),
              //                 hintText: 'Find Restaurants',
              //                 hintStyle:
              //                     TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 16.sp),
              //                 border: InputBorder.none,
              //               ),
              //               style: TextStyle(color: Colors.black),
              //               onSubmitted: (searchQuery) {
              //                 // RestaurantsApiProvider().searchRestaurants(searchQuery);
              //               },
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 96.h,
              //         ),
              //         Text(
              //           Strings.appTitle,
              //           style: TextStyle(
              //             color: titleTextColorOne,
              //             fontSize: 36.sp,
              //             fontWeight: FontWeight.w800,
              //             fontFamily: 'cursive',
              //           ),
              //         ),
              //         Spacer(),
              //         Spacer()
              //       ],
              //     ),
              //   ),
              // );
            }
          },
        ),
      ),
    );
  }
}
