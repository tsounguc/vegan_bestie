import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/custom_circle_avatar.dart';
import 'package:sheveegan/core/common/widgets/custom_drawer.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurants_home_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_product_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String id = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  Position? userLocation;
  final List<Widget> _pages = [
    const ScanProductHomePage(),
    RestaurantsHomePage(),
  ];

  void _updateIndex(int value) {
    // final currentUserLocation = BlocProvider.of<RestaurantsBloc>(
    //   context,
    // ).currentLocation;
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 1) {
        BlocProvider.of<RestaurantsBloc>(
          context,
        ).add(const LoadGeolocationEvent());
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Stack(
        children: [
          Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            extendBody: true,
            appBar: AppBar(
              leadingWidth: 80,
              toolbarHeight: toolbarHeight,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: _currentIndex == 0
                  ? null
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: VeganBestieLogoWidget(size: 25, fontSize: 35),
                    ),
              actions: [
                Visibility(
                  visible: false,
                  // visible: !(state is LoggedInState),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton(
                      onPressed: () {
                        // TODO(Login-Handler): Push to login Screen
                        // BlocProvider.of<AuthCubit>(context).goToLoginPage();
                      },
                      child: Text(
                        'Log In',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: _pages[_currentIndex],
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: _updateIndex,
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(
                        _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Restaurants',
                      icon: Icon(
                        _currentIndex == 1 ? Icons.dinner_dining : Icons.dinner_dining_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
