// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/loading.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';

import 'core/constants/clipping_class.dart';
import 'core/constants/size_config.dart';
import 'core/constants/strings.dart';
import 'core/custom_appbar_title_widget.dart';
import 'core/custom_circle_avatar.dart';
import 'core/custom_drawer.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/restaurants/presentation/pages/restaurants_home_page.dart';
import 'features/scan_product/presentation/pages/scan_product_home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  Position? userLocation;
  List _pages = [
    ScanProductHomePage(),
    RestaurantsHomePage(),
  ];

  void _updateIndex(int value) {
    Position? currentUserLocation = BlocProvider.of<GeolocationBloc>(context).currentLocation;
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
    // BlocProvider.of<AuthCubit>(context).currentUser();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return LoadingPage();
        }
        // if (state is LoggedInState) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: Stack(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(bottom: 2.h),
              // child: ClipPath(
              //   clipper: ClippingClassTwo(),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //     decoration: BoxDecoration(
              //       // color: Theme.of(context).colorScheme.background.withOpacity(0.9),
              //       color: Colors.green.withOpacity(0.6),
              //       // gradient: LinearGradient(
              //       //   begin: Alignment.topLeft,
              //       //   end: Alignment.bottomRight,
              //       //   colors: [
              //       //     Colors.green.shade900,
              //       //     Colors.green.shade700,
              //       //     Colors.green.shade500,
              //       //     Colors.green.shade300,
              //       //   ],
              //       // ),
              //     ),
              //   ),
              // ),
              // ),
              Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                extendBody: true,
                appBar: AppBar(
                  leadingWidth: 80,
                  toolbarHeight: toolbarHeight,
                  backgroundColor: Colors.transparent,
                  leading: Visibility(
                    visible: state is LoggedInState,
                    child: IconButton(
                      icon: CustomCircleAvatar(
                        size: 25,
                      ),
                      onPressed: () => scaffoldKey.currentState!.openDrawer(),
                    ),
                  ),
                  centerTitle: true,
                  title: _currentIndex == 0
                      ? null
                      : CustomAppbarTitleWidget(
                          imageOneName: 'assets/bread.png', imageTwoName: 'assets/tomato.png'),
                  actions: [
                    Visibility(
                        visible: false,
                        // visible: !(state is LoggedInState),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: TextButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).goToLoginPage();
                              },
                              child: Text("Log In", style: Theme.of(context).textTheme.bodyLarge
                                  // style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  )),
                        ))
                  ],
                ),
                drawer: state is LoggedInState ? CustomDrawer() : null,
                body: _pages[_currentIndex],
                bottomNavigationBar: Container(
                  // height: MediaQuery.of(context).size.height / 12,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: _currentIndex,
                      onTap: _updateIndex,
                      items: [
                        BottomNavigationBarItem(
                          label: "Home",
                          icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home_outlined),
                        ),
                        BottomNavigationBarItem(
                          label: "Restaurants",
                          icon: Icon(_currentIndex == 1 ? Icons.dinner_dining : Icons.dinner_dining_outlined),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        // }
        // return Container();
      },
    );
  }
}
