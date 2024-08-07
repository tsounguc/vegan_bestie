import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/food_product_reports_provider.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/submitted_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/tab_navigator.dart';
import 'package:sheveegan/core/common/app/providers/theme_mode_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/dashboard/presentation/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product_report.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get width => size.width;

  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  UserEntity? get currentUser => userProvider.user;

  BottomNavigationBarProvider get dashboardControllerProvider => read<BottomNavigationBarProvider>();

  RestaurantsNearMeProvider get restaurantsNearMeProvider => read<RestaurantsNearMeProvider>();

  Position? get currentLocation => restaurantsNearMeProvider.currentLocation;

  double get radius => restaurantsNearMeProvider.radius;

  List<Restaurant>? get restaurants => restaurantsNearMeProvider.restaurants;

  Set<Marker>? get markers => restaurantsNearMeProvider.markers;

  int get currentIndex => dashboardControllerProvider.currentIndex;

  SavedProductsProvider get savedProductsProvider => read<SavedProductsProvider>();

  List<FoodProduct>? get savedProductsList => savedProductsProvider.savedProductsList;

  SavedRestaurantsProvider get savedRestaurantsProvider => read<SavedRestaurantsProvider>();

  List<Restaurant>? get savedRestaurantsList => savedRestaurantsProvider.savedRestaurantsList;

  FoodProductReportsProvider get reportsProvider => read<FoodProductReportsProvider>();

  List<FoodProductReport>? get reports => reportsProvider.reports;

  SubmittedRestaurantsProvider get submittedRestaurantsProvider => read<SubmittedRestaurantsProvider>();

  ThemeModeProvider get themeModeProvider => read<ThemeModeProvider>();

  ThemeMode get themeMode => themeModeProvider.themeMode;

  TabNavigator get tabNavigator => read<TabNavigator>();

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));

  Map<int, String> get daysOfTheWeek => <int, String>{
        0: 'Sunday',
        1: 'Monday',
        2: 'Tuesday',
        3: 'Wednesday',
        4: 'Thursday',
        5: 'Friday',
        6: 'Saturday',
      };
}
