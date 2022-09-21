import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/data/models/restaurant_model.dart';
import 'package:sheveegan/data/providers/restaurants_api_provider.dart';
import 'package:sheveegan/logic/bloc/restaurants_bloc.dart';
import 'package:sheveegan/logic/bloc/restaurants_bloc.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../logic/bloc/geolocation_bloc.dart';

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
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
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
                    // bool hasVegan =
                    //     hasVeganOptions(length, state.results?.results?.data?[index].dietaryRestrictions);
                    // if (hasVegan)
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Card(
                        color: Colors.green.shade50,
                        // elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          children: [
                            state.results!.businesses![index].imageUrl!.isNotEmpty &&
                                    state.results?.businesses?[index].imageUrl != null
                                ? Padding(
                                    padding: EdgeInsets.only(left: 8.0.w),
                                    child: Ink(
                                      height: 100.r,
                                      width: 100.r,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              state.results!.businesses![index].imageUrl!
                                              // "https://maps.googleapis.com/maps/api/place/photo?photoreference=${state.results?.businesses?[index].imageUrl}&sensor=false&maxheight=${state.results?.restaurants?[index].photos?[0].height}&maxwidth=${state.results?.restaurants?[index].photos?[0].width}&key=AIzaSyDuY9PTMORog1oIv36qdojLvypoddmmvRY",
                                              ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      left: 8.0.w,
                                    ),
                                    child: Container(
                                      height: 100.r,
                                      width: 100.r,
                                      color: Colors.blueGrey,
                                      child: Icon(
                                        Icons.restaurant,
                                        size: 30.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(16.0.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: SizedBox(
                                            width: 140.w,
                                            child: Text(
                                              state.results!.businesses![index].name!,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${(state.results!.businesses![index].distance! / 1609.344).round()} mi",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.redAccent,
                                                size: 12.r,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${state.results!.businesses![index].location!.city}",
                                                  // + " ${state.results!.businesses![index].location!.displayAddress![1]}",
                                                  style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                state.results!.businesses![index].isClosed! ? "Closed" : "Open",
                                                style: TextStyle(
                                                    color: state.results!.businesses![index].isClosed!
                                                        ? Colors.red
                                                        : Colors.green,
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${state.results?.businesses?[index].price}",
                                          style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.r,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RatingBarIndicator(
                                          rating: state.results!.businesses![index].rating!,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                          unratedColor: Colors.grey.shade400,
                                          itemSize: 15.r,
                                        ),
                                        SizedBox(
                                          width: 7.w,
                                        ),
                                        Text(
                                          "${state.results!.businesses![index].reviewCount} reviews",
                                          style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            dietRestrictions!,
                                            style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    // return Container();
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

  // bool hasVeganOptions(
  //   int length,
  //   List<DietaryRestriction>? dietaryRestrictions,
  // ) {
  //   bool hasVeganOptions = false;
  //   dietaryRestrictions?.forEach((dietaryRestriction) {
  //     if (dietaryRestriction.name!.toLowerCase().contains('vegan option')) {
  //       hasVeganOptions = true;
  //     }
  //   });
  //   return hasVeganOptions;
  // }
}
