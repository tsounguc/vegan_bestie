import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/tab_navigator.dart';
import 'package:sheveegan/core/common/screens/persistent_screen/persistent_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/scan_product_home_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/profile_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurants_home_page.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ScanProductHomePage(),
        ),
      ),
      child: const PersistentScreen(
        body: ScanProductHomePage(),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: RestaurantsHomePage(),
        ),
      ),
      child: PersistentScreen(body: RestaurantsHomePage()),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: const ProfileScreen(),
        ),
      ),
      child: const PersistentScreen(body: ProfileScreen()),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
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
