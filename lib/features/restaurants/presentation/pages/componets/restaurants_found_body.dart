import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/horizontal_restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/map_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/utils/restaurants_utils.dart';
import 'package:sheveegan/themes/app_theme.dart';

//ignore: must_be_immutable
class RestaurantsFoundBody extends StatelessWidget {
  RestaurantsFoundBody({
    required this.restaurants,
    required this.userLocation,
    required this.markers,
    super.key,
  });

  final List<Restaurant> restaurants;

  final Position userLocation;

  final Set<Marker> markers;

  final _scrollThreshold = 0.80;

  Widget mapView = LoadingPage();

  Widget currentListView = const SliverToBoxAdapter();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //the initState will allow us to add our scroll listener and initialize the BloC
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      markers: context.markers ?? {},
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
                      markers: state.markers,
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
                      markers: context.markers ?? {},
                    );
                  }
                },
                listener: (BuildContext context, RestaurantsState state) {
                  if (state is LoadingRestaurants) {
                    CoreUtils.showLoadingDialog(context);
                  }
                },
              ),
            );
          },
        ),
        DraggableScrollableSheet(
          key: UniqueKey(),
          minChildSize: 0.05,
          maxChildSize: 0.90,
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
                    toolbarHeight: 30,
                    title: Center(
                      child: SizedBox(
                        width: 100,
                        // height: 30,
                        child: Divider(
                          thickness: 5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    primary: false,
                    pinned: true,
                    centerTitle: true,
                  ),
                  BlocBuilder<RestaurantsCubit, RestaurantsState>(
                    builder: (context, state) {
                      if (state is LoadingRestaurants || state is RestaurantsInitial) {
                        return currentListView = SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 75.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Loading...',
                                    style: TextStyle(fontSize: 12.sp, color: AppTheme.lightPrimaryColor),
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
                          final sortedRestaurants = context.restaurants!
                              // ..sort(
                              //   (a, b) => RestaurantsUtils.sortByDistance(context.currentLocation!, a, b),
                              // )
                              ;
                          return currentListView = SliverList.builder(
                            itemCount:
                                context.hasReachedEnd ? sortedRestaurants.length : sortedRestaurants.length + 1,
                            itemBuilder: (context, restaurantIndex) {
                              if (restaurantIndex >= sortedRestaurants.length &&
                                  !(state as RestaurantsLoaded).hasReachedEnd) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Loading more...',
                                        style: TextStyle(fontSize: 12.sp, color: AppTheme.lightPrimaryColor),
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
      ],
    );
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

  Future<BitmapDescriptor> getMarkerIcon(
    String imageUrl,
    Size size, {
    required bool isFromAsset,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final radius = Radius.circular(size.width / 2);

    final shadowPaint = Paint()..color = AppTheme.lightPrimaryColor.withAlpha(100);
    const shadowWidth = 8.0;

    final borderPaint = Paint()..color = Colors.white;
    const borderWidth = 2.0;

    const imageOffset = shadowWidth + borderWidth;

    const triangleH = 100;
    const triangleW = 25.0;
    // Shadow circle
    canvas
      ..drawPath(
        Path()
          ..moveTo(size.width / 2 - triangleW / 2, size.height)
          ..lineTo(size.width / 2, triangleH + size.height)
          ..lineTo(size.width / 2 + triangleW, size.height)
          ..arcToPoint(
            Offset(size.width / 2, triangleH + size.height),
          ),
        shadowPaint,
      )
      ..drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint,
      )

      // Border circle
      ..drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
            shadowWidth,
            shadowWidth,
            size.width - (shadowWidth * 2),
            size.height - (shadowWidth * 2),
          ),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint,
      );

    // Oval for the image
    final oval =
        Rect.fromLTWH(imageOffset, imageOffset, size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Clip oval path for image
    canvas.clipPath(Path()..addOval(oval));

    // Fetch and draw the network image
    final image = isFromAsset ? await _fetchAssetsImage(imageUrl) : await _fetchNetworkImage(imageUrl);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.cover);

    // Convert canvas to image
    final markerAsImage = await pictureRecorder.endRecording().toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> _fetchNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final imageBytes = response.bodyBytes;
    final codec = await ui.instantiateImageCodec(imageBytes);
    final fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<ui.Image> _fetchAssetsImage(String imageUrl) async {
    final data = await rootBundle.load(imageUrl);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 100);
    final fi = await codec.getNextFrame();
    return fi.image;
  }
}
