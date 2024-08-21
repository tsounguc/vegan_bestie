import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/dashboard/presentation/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/features/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const String id = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return StreamBuilder<UserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.read<UserProvider>().user = snapshot.data;
        }

        return Consumer<BottomNavigationBarProvider>(
          builder: (context, controller, child) {
            if (controller.currentIndex == 1) {
              debugPrint('if currentIndex is 1 loadGeoLocation from Dashboard');
              BlocProvider.of<RestaurantsCubit>(context).loadGeoLocation();
            }
            if (controller.currentIndex == 2) {
              if (context.currentLocation == null) {
                BlocProvider.of<RestaurantsCubit>(context).loadGeoLocation();
              }
              loadUserSavedData(context);
            }
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                appBar: controller.currentIndex == 0 || controller.currentIndex == 2
                    ? null
                    : AppBar(
                        leadingWidth: 80,
                        toolbarHeight: 80,
                        centerTitle: true,
                        title: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: const VeganBestieLogoWidget(
                            size: 25,
                            fontSize: 35,
                          ),
                        ),
                      ),
                body: IndexedStack(
                  index: controller.currentIndex,
                  children: controller.screens,
                ),
                // body: controller.screens[controller.currentIndex],
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.currentIndex,
                    onTap: controller.changeIndex,
                    items: [
                      BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(
                          controller.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Restaurants',
                        icon: Icon(
                          controller.currentIndex == 1 ? Icons.dinner_dining : Icons.dinner_dining_outlined,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: 'Profile',
                        icon: Icon(
                          controller.currentIndex == 2 ? Icons.person : Icons.person_outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void loadUserSavedData(BuildContext context) {
    final savedRestaurantsIds = context.currentUser?.savedRestaurantsIds ?? [];
    if (savedRestaurantsIds.length != context.savedRestaurantsList?.length) {
      debugPrint('getSavedRestaurantsList from DashBoard');
      BlocProvider.of<RestaurantsCubit>(context).getSavedRestaurants(savedRestaurantsIds);
    }

    final savedProductBarcodes = context.currentUser?.savedProductsBarcodes ?? [];
    if (savedProductBarcodes.length != context.savedProductsList?.length) {
      debugPrint('savedProductsList in ScanProductHome');
      BlocProvider.of<FoodProductCubit>(context).fetchProductsList(savedProductBarcodes);
    }
  }
}
