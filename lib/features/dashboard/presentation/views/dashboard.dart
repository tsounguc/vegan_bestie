import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
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
  Widget build(BuildContext buildContext) {
    return StreamBuilder<UserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.userProvider.user = snapshot.data;
        }

        return Consumer<BottomNavigationBarProvider>(
          builder: (context, controller, child) {
            final savedBarcodes = context.userProvider.user!.savedProductsBarcodes;

            if (savedBarcodes.length != context.savedProductsProvider.savedProductsList?.length) {
              BlocProvider.of<FoodProductCubit>(
                context,
              ).fetchProductsList(savedBarcodes);
            }

            final savedRestaurantsIds = context.userProvider.user!.savedRestaurantsIds;

            if (savedRestaurantsIds.length != context.savedRestaurantsProvider.savedRestaurantsList?.length) {
              BlocProvider.of<RestaurantsCubit>(
                context,
              ).getSavedRestaurants(savedRestaurantsIdsList: savedRestaurantsIds);
            }

            if (controller.currentIndex == 1) {
              BlocProvider.of<RestaurantsCubit>(
                context,
              ).loadGeoLocation();
            }

            if (snapshot.data?.isAdmin ?? false) {
              BlocProvider.of<FoodProductCubit>(
                context,
              ).fetchReports();
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
                body: controller.screens[controller.currentIndex],
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
                    onTap: (index) {
                      controller.changeIndex(index);
                      BlocProvider.of<RestaurantsCubit>(context).loadGeoLocation();
                    },
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
}
