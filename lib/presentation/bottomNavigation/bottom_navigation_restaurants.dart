import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/data/models/restaurant_model.dart';
import 'package:sheveegan/data/models/yelp_restaurants_search_model.dart';
import 'package:sheveegan/data/providers/restaurants_api_provider.dart';
import 'package:sheveegan/logic/bloc/restaurants_bloc.dart';
import 'package:sheveegan/logic/bloc/restaurants_bloc.dart';
import 'package:sheveegan/presentation/widgets/loading.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../logic/bloc/geolocation_bloc.dart';
import '../widgets/restaurant_card.dart';

class BottomNavigationRestaurants extends StatelessWidget {
  const BottomNavigationRestaurants({Key? key}) : super(key: key);
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
            if (state is RestaurantsLoadingState) {
              return Scaffold(
                appBar: AppBar(
                  // iconTheme: Theme.of(context).iconTheme,
                  toolbarHeight: 65.h,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      Strings.appTitle,
                      style: TextStyle(
                        // color: Theme.of(context).backgroundColor,
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ),
                  // elevation: 0,
                  backgroundColor: Theme.of(context).backgroundColor,
                  // backgroundColor: Colors.green.shade50,
                ),
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Visibility(
                        visible: false,
                        child: Text(
                          "Searching...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
            } else if (state is RestaurantsFoundState) {
              return Scaffold(
                appBar: AppBar(
                  // iconTheme: Theme.of(context).iconTheme,
                  toolbarHeight: 65.h,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      Strings.appTitle,
                      style: TextStyle(
                        // color: Theme.of(context).backgroundColor,
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'cursive',
                      ),
                    ),
                  ),
                  // elevation: 0,
                  backgroundColor: Theme.of(context).backgroundColor,
                  // backgroundColor: Colors.green.shade50,
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                // backgroundColor: Colors.green.shade50,
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.results?.businesses?.length,
                  itemBuilder: (context, index) {
                    int? length = state.results?.businesses?[index].categories?.length;
                    String? dietRestrictions = "";
                    for (int i = 0; i < length!; i++) {
                      dietRestrictions =
                          dietRestrictions! + "${state.results?.businesses?[index].categories?[i].title}";
                      if (i < length - 1) {
                        dietRestrictions = dietRestrictions + " | ";
                      }
                    }
                    return RestaurantCard(
                      dietRestrictions: dietRestrictions,
                      business: state.results!.businesses![index],
                    );
                  },
                ),
              );
            } else {
              return Scaffold(
                // appBar: AppBar(
                //   iconTheme: Theme.of(context).iconTheme,
                //   toolbarHeight: 100.h,
                //   automaticallyImplyLeading: false,
                //   centerTitle: true,
                //   title: Text(
                //     Strings.appTitle,
                //     style: TextStyle(
                //       color: titleTextColorOne,
                //       fontSize: 36.sp,
                //       fontWeight: FontWeight.w800,
                //       fontFamily: 'cursive',
                //     ),
                //   ),
                //   elevation: 0,
                //   backgroundColor: Theme.of(context).backgroundColor,
                // ),
                // backgroundColor: Theme.of(context).backgroundColor,
                backgroundColor: Theme.of(context).backgroundColor,
                body: Container(
                  padding: EdgeInsets.only(top: 56.h, right: 16.w, bottom: 8.h, left: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).backgroundColor,
                              ),
                              // suffixIcon: IconButton(
                              //   icon: Icon(
                              //     Icons.cancel,
                              //     color: Theme.of(context).backgroundColor,
                              //   ),
                              //   onPressed: () {},
                              // ),
                              hintText: 'Find Restaurants',
                              hintStyle: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 16.sp),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black),
                            onSubmitted: (searchQuery) {
                              // RestaurantsApiProvider().searchRestaurants(searchQuery);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 96.h,
                      ),
                      Text(
                        Strings.appTitle,
                        style: TextStyle(
                          color: titleTextColorOne,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'cursive',
                        ),
                      ),
                      Spacer(),
                      Spacer()
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
