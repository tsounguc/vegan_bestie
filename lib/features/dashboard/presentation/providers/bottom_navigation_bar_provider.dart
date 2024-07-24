import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/tab_navigator.dart';
import 'package:sheveegan/core/common/screens/persistent_screen/persistent_screen.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/food_product/presentation/pages/scan_product_home_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:sheveegan/features/profile/presentation/screens/profile_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurants_home_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: serviceLocator<FoodProductCubit>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
              ),
            ],
            child: const ScanProductHomePage(),
          ),
        ),
      ),
      child: const PersistentScreen(
        body: ScanProductHomePage(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: serviceLocator<RestaurantsCubit>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
              ),
            ],
            child: RestaurantsHomePage(),
          ),
        ),
      ),
      child: PersistentScreen(
        body: RestaurantsHomePage(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: serviceLocator<FoodProductCubit>(),
              ),
              BlocProvider.value(
                value: serviceLocator<RestaurantsCubit>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
              ),
              BlocProvider.value(
                value: serviceLocator<NotificationCubit>(),
              ),
            ],
            child: const ProfileScreen(),
          ),
        ),
      ),
      child: const PersistentScreen(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    // if (index == 1) {
    //   BlocProvider.of<RestaurantsBloc>(
    //     context,
    //   ).add(const LoadGeolocationEvent());
    // }
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
