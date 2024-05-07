import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String id = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext buildContext) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FoodProductCubit, FoodProductState>(
          listener: (context, state) {
            if (state is SavedProductsListFetched) {
              context.savedProductsProvider.savedProductsList = state.savedProductsList;
            }
          },
        ),
        BlocListener<RestaurantsBloc, RestaurantsState>(
          listener: (context, state) {
            if (state is SavedRestaurantsListFetched) {
              context.savedRestaurantsProvider.savedRestaurantsList = state.savedRestaurantsList;
            }
          },
        ),
      ],
      child: StreamBuilder<UserModel>(
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
            final savedBarcodesList = context.userProvider.user!.savedProductsBarcodes;

            if (savedBarcodesList?.length != context.savedProductsProvider.savedProductsList?.length) {
              BlocProvider.of<FoodProductCubit>(
                context,
              ).fetchProductsList(savedBarcodesList!);
            }
            final savedRestaurantsIdsList = context.userProvider.user!.savedRestaurantsIds;
            if (savedRestaurantsIdsList?.length != context.savedRestaurantsProvider.savedRestaurantsList?.length) {
              BlocProvider.of<RestaurantsBloc>(
                context,
              ).add(
                FetchSavedRestaurantsListEvent(
                  savedRestaurantsIdsList: savedRestaurantsIdsList!,
                ),
              );
            }
            // context.savedProductsProvider.initSavedProductList(
            //   context.userProvider.user!.savedFoodProducts ?? [],
            //   context,
            // );
          }

          return Consumer<BottomNavigationBarProvider>(
            builder: (context, controller, child) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Scaffold(
                  // key: scaffoldKey,
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  appBar: controller.currentIndex == 0 || controller.currentIndex == 2
                      ? null
                      : AppBar(
                          leadingWidth: 80,
                          toolbarHeight: 80,
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          centerTitle: true,
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const VeganBestieLogoWidget(size: 25, fontSize: 35),
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
                      // onTap: controller.changeIndex,
                      onTap: (int index) {
                        controller.changeIndex(index);
                        if (index == 1) {
                          BlocProvider.of<RestaurantsBloc>(
                            context,
                          ).add(const LoadGeolocationEvent());
                        }
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
      ),
    );
  }
}
