// import 'dart:html';

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/logic/bloc/geolocation_bloc.dart';

import 'bottomNavigation/bottom_navigation_home.dart';
import 'bottomNavigation/bottom_navigation_restaurants.dart';

class VeganBestieHome extends StatefulWidget {
  const VeganBestieHome({Key? key}) : super(key: key);

  @override
  State<VeganBestieHome> createState() => _VeganBestieHomeState();
}

class _VeganBestieHomeState extends State<VeganBestieHome> {
  int _currentIndex = 0;
  List _pages = [
    BottomNavigationHomePage(),
    BottomNavigationRestaurants(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 1) {
        BlocProvider.of<GeolocationBloc>(context).add(LoadGeolocationEvent());
        // BlocProvider.of<RestaurantsBloc>(context).add(GetRestaurantsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      backgroundColor: Theme.of(buildContext).backgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        iconSize: 20.r,
        onTap: _updateIndex,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(label: "Restaurants", icon: Icon(Icons.restaurant))
        ],
      ),
    );
  }
}
