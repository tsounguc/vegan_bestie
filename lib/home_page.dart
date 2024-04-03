import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/vegan_bestie_logo_widget.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/size_config.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String id = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext buildContext) {
    return StreamBuilder<UserModel>(
      stream: serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (event) => UserModel.fromMap(event.data()!),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          context.read<UserProvider>().user = snapshot.data;
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
                        toolbarHeight: toolbarHeight,
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        centerTitle: true,
                        title: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: VeganBestieLogoWidget(size: 25, fontSize: 35),
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
    );
  }
}
