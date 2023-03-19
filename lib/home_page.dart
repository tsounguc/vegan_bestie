// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/loading.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';

import 'core/constants/size_config.dart';
import 'core/constants/strings.dart';
import 'core/custom_circle_avatar.dart';
import 'core/custom_drawer.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/scan_product/presentation/pages/scan_product_home_page.dart';
import 'features/restaurants/presentation/pages/restaurants_home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  List _pages = [
    ScanProductHomePage(),
    RestaurantsHomePage(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 1) {
        BlocProvider.of<GeolocationBloc>(context).add(LoadGeolocationEvent());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).currentUser();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return LoadingPage();
        }
        if (state is LoggedInState) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Theme.of(buildContext).colorScheme.background,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(buildContext).colorScheme.background,
              leadingWidth: 80,
              toolbarHeight: toolbarHeight,
              leading: IconButton(
                icon: CustomCircleAvatar(
                  size: 25,
                ),
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
              ),
              centerTitle: true,
              title: _currentIndex == 0
                  ? null
                  : Padding(
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
            ),
            drawer: state.currentUser.uid != null ? CustomDrawer() : null,
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 1,
              backgroundColor: Theme.of(context).colorScheme.background,
              // fixedColor: Colors.purple,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade500,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              iconSize: 35,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),

              onTap: _updateIndex,
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Restaurants",
                  icon: Icon(Icons.dinner_dining),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
