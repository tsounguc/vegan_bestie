import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheveegan/core/common/screens/webview/web_view_screen.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/common/widgets/expandable_text.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/extensions/string_extensions.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_review_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/custom_page_view.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/dine_in_takeout_delivery.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/is_open_now.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/rating_and_reviews_count.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/review_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/update_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RestaurantDetailsPage({
    // required this.restaurantDetails,
    required this.restaurant,
    super.key,
  });

  // final RestaurantDetails restaurantDetails;
  final Restaurant restaurant;
  static const String id = '/restaurantDetailsPage';

  final dateFormat = DateFormat('h:mm a');

  final Map<int, String> weekDays = {
    0: 'Sunday',
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
  };

  final controller = ScrollController();

  void unsaveRestaurant(
    Restaurant restaurant,
    BuildContext context,
  ) {
    BlocProvider.of<RestaurantsCubit>(
      context,
    ).unSaveRestaurant(restaurant: restaurant);
    // CoreUtils.showSnackBar(
    //   context,
    //   'Restaurant unsaved',
    // );
  }

  void saveRestaurant(Restaurant product, BuildContext context) {
    BlocProvider.of<RestaurantsCubit>(
      context,
    ).saveRestaurant(restaurant);
    // CoreUtils.showSnackBar(
    //   context,
    //   'Restaurant saved',
    // );
  }

  double totalRestaurantRating(List<RestaurantReview> reviews) {
    var count = 0;
    var rating = 0.0;

    for (final review in reviews) {
      count += 1;
      rating += (review.rating - rating) / count;
    }

    return rating;
  }

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
    );
    final elevatedButtonStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        context.theme.cardTheme.color,
      ),
      surfaceTintColor: MaterialStatePropertyAll(
        context.theme.cardTheme.color,
      ),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
      ),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
      ),
      elevation: const MaterialStatePropertyAll(
        2,
      ),
    );
    final formattedAddress = '${restaurant.streetAddress}, ${restaurant.city},'
        '${restaurant.state} ${restaurant.zipCode}';
    final appleUrl = 'https://maps.apple.com/?q=${restaurant.name}'
        ' $formattedAddress';
    final googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${restaurant.name}'
        ' $formattedAddress';
    return StreamBuilder<UserModel>(
      stream: serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (event) => UserModel.fromMap(event.data()!),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.userProvider.user = snapshot.data;
        }
        final user = context.userProvider.user;

        var isSaved = user!.savedRestaurantsIds.contains(
          restaurant.id,
        );

        return StreamBuilder<List<RestaurantReview>>(
          stream: serviceLocator<FirebaseFirestore>()
              .collection('restaurantReviews')
              .where('restaurantId', isEqualTo: restaurant.id)
              .snapshots()
              .map(
                (event) => event.docs
                    .map(
                      (e) => RestaurantReviewModel.fromMap(e.data()),
                    )
                    .toList(),
              ),
          builder: (context, snapshot) {
            final reviews =
                snapshot.hasData ? snapshot.data! : <RestaurantReview>[];
            return BlocListener<RestaurantsCubit, RestaurantsState>(
              listener: (context, state) {
                if (state is RestaurantSaved) {
                  CoreUtils.showSnackBar(
                    context,
                    'Restaurant saved',
                  );
                  final restaurantIds =
                      context.userProvider.user?.savedRestaurantsIds ?? [];
                  BlocProvider.of<RestaurantsCubit>(context)
                      .getSavedRestaurants(
                          savedRestaurantsIdsList: restaurantIds);
                }
                if (state is RestaurantUnSaved) {
                  CoreUtils.showSnackBar(
                    context,
                    'Restaurant unsaved',
                  );
                  final restaurantIds =
                      context.userProvider.user?.savedRestaurantsIds ?? [];
                  BlocProvider.of<RestaurantsCubit>(context)
                      .getSavedRestaurants(
                          savedRestaurantsIdsList: restaurantIds);
                }
                if (state is SavedRestaurantsListFetched) {
                  context.savedRestaurantsProvider.savedRestaurantsList =
                      state.savedRestaurantsList;
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  leadingWidth: 80,
                  toolbarHeight: 80,
                  leading: !Navigator.of(context).canPop()
                      ? null
                      : CustomBackButton(
                          color: context.theme.iconTheme.color!,
                        ),
                  centerTitle: false,
                  // title: SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  //   child: const VeganBestieLogoWidget(
                  //     size: 25,
                  //     fontSize: 35,
                  //   ),
                  // ),
                  actions: [
                    IconButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shape: const CircleBorder(),
                        // backgroundColor: Colors.white.withOpacity(0.7),
                        padding: EdgeInsets.zero,
                      ),
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_outline,
                        color: isSaved
                            ? Colors.amberAccent
                            : context.theme.iconTheme.color,
                      ),
                      onPressed: () => isSaved
                          ? unsaveRestaurant(restaurant, context)
                          : saveRestaurant(restaurant, context),
                    ),
                    PopupMenuButton(
                      // padding: EdgeInsets.only(
                      //   right: 10.w,
                      // ),
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: context.theme.appBarTheme.iconTheme?.color,
                      ),
                      surfaceTintColor: context.theme.cardTheme.color,
                      color: context.theme.cardTheme.color,
                      offset: const Offset(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      itemBuilder: (_) {
                        return [
                          if (context.userProvider.user?.isAdmin ?? false)
                            PopupMenuItem<void>(
                              onTap: () => Navigator.of(context).pushNamed(
                                UpdateRestaurantScreen.id,
                                arguments: UpdateRestaurantScreenArguments(
                                  '',
                                  restaurant,
                                ),
                              ),
                              child: PopupItem(
                                title: context.currentUser?.isAdmin == true
                                    ? 'Edit Restaurant'
                                    : 'Suggest Restaurant Edit',
                                icon: Icon(
                                  Icons.edit_outlined,
                                  color: context.theme.iconTheme.color,
                                ),
                              ),
                            ),
                          PopupMenuItem<void>(
                            onTap: () => isSaved
                                ? unsaveRestaurant(restaurant, context)
                                : saveRestaurant(restaurant, context),
                            child: PopupItem(
                              title: isSaved ? 'Unsave' : 'Save',
                              icon: Icon(
                                Icons.bookmark,
                                color: context.theme.iconTheme.color,
                              ),
                            ),
                          ),

                          // PopupMenuItem<void>(
                          //   onTap: () => Navigator.of(context).pushNamed(
                          //     SettingsPage.id,
                          //     arguments: context.read<AuthBloc>(),
                          //   ),
                          //   child: PopupItem(
                          //     title: 'Settings',
                          //     icon: Icon(
                          //       Icons.settings_outlined,
                          //       color: context.theme.iconTheme.color,
                          //     ),
                          //   ),
                          // ),
                          // const PopupMenuItem<void>(
                          //   // onTap: () => context.push(const Placeholder()),
                          //   child: PopupItem(
                          //     title: 'Notifications',
                          //     icon: Icon(
                          //       Icons.notifications,
                          //       color: Color(0xFF757C8E),
                          //     ),
                          //   ),
                          // ),
                          // const PopupMenuItem<void>(
                          //   // onTap: () => context.push(const Placeholder()),
                          //   child: PopupItem(
                          //     title: 'Help',
                          //     icon: Icon(
                          //       Icons.help_outline_outlined,
                          //       color: Color(0xFF757C8E),
                          //     ),
                          //   ),
                          // ),
                          PopupMenuItem<void>(
                            height: 1,
                            padding: EdgeInsets.zero,
                            child: Divider(
                              height: 1,
                              color: Colors.grey.shade300,
                              endIndent: 10,
                              indent: 10,
                            ),
                          ),
                        ];
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: CustomPageView(restaurant: restaurant),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    restaurant.name.capitalizeFirstLetter(),
                                    style: baseTextStyle.copyWith(
                                      color: context
                                          .theme.textTheme.bodyMedium?.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                IsOpenNowWidget(
                                  openHours: restaurant.openHours,
                                  isFromDetailedPage: true,
                                  fontSize: 10.sp,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  SizedBox(
                                    width: context.width * 0.54,
                                    child: Text(
                                      '${restaurant.streetAddress}, ${restaurant.city}, ${restaurant.state}',
                                      style: baseTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0005,
                            ),
                            Visibility(
                              visible: restaurant.dineIn ||
                                  restaurant.takeout ||
                                  restaurant.delivery,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                  top: 5,
                                  left: 5,
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: DineInTakeoutDeliveryWidget(
                                    dineIn: restaurant.dineIn,
                                    takeout: restaurant.takeout,
                                    delivery: restaurant.delivery,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 15, bottom: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: elevatedButtonStyle,
                                    onPressed: () {
                                      launchUrl(
                                        Uri(
                                          scheme: 'tel',
                                          path: restaurant.phoneNumber,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.call,
                                      color: context.theme.iconTheme.color,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(
                                          context,
                                        ).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    Strings.callText,
                                    style: baseTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: elevatedButtonStyle,
                                    onPressed: () {
                                      if (Platform.isIOS) {
                                        launchUrl(
                                          Uri.parse(appleUrl),
                                          mode: LaunchMode
                                              .externalNonBrowserApplication,
                                        );
                                      } else {
                                        launchUrl(
                                          Uri.parse(googleUrl),
                                          mode: LaunchMode
                                              .externalNonBrowserApplication,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.directions,
                                      color: context.theme.iconTheme.color,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(
                                          context,
                                        ).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    Strings.directionsText,
                                    style: baseTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: elevatedButtonStyle,
                                    onPressed: () {
                                      if (restaurant.websiteUrl.isNotEmpty) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<WebViewScreen>(
                                            builder: (_) => WebViewScreen(
                                              url: restaurant.websiteUrl,
                                            ),
                                          ),
                                        );
                                      } else {
                                        CoreUtils.showSnackBar(
                                          context,
                                          'No Website Found',
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.launch,
                                      color: context.theme.iconTheme.color,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(
                                          context,
                                        ).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    Strings.websiteText,
                                    style: baseTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: elevatedButtonStyle,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RestaurantReviewScreen.id,
                                        arguments: restaurant,
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: context.theme.iconTheme.color,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(
                                          context,
                                        ).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    Strings.leaveReview,
                                    style: baseTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.035,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 25,
                          ).copyWith(bottom: 10),
                          child: SectionHeader(
                            sectionTitle: 'About Restaurant',
                            seeAll: false,
                            onSeeAll: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15)
                              .copyWith(left: 20),
                          child: ExpandableText(
                            context,
                            text: restaurant.description ??
                                restaurant.name.capitalizeFirstLetter(),
                            style: baseTextStyle.copyWith(
                              color: restaurant.description != null &&
                                      restaurant.description!.isNotEmpty
                                  ? context.theme.textTheme.titleSmall?.color
                                  : Colors.grey.shade500,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Reviews',
                            style: baseTextStyle.copyWith(
                              // color: Colors.grey.shade800,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14)
                              .copyWith(top: 5),
                          child: RatingAndReviewsCountWidget(
                            rating: totalRestaurantRating(reviews),
                            reviewCount: reviews.length,
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (reviews.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 35),
                            child: SizedBox(
                              height: 150,
                              width: context.width * 0.75,
                              child: Text(
                                'No reviews for ${restaurant.name.capitalizeFirstLetter()}'
                                '\nBe the first to leave a review!',
                                style: baseTextStyle.copyWith(
                                  color: Colors.grey.shade500,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            controller: controller,
                            itemCount: reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: ReviewCard(
                                  review: reviews[index],
                                  restaurant: restaurant,
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 75),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
