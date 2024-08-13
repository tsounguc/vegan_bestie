import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/food_product/presentation/pages/add_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/profile/presentation/screens/profile_picture_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/reports_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/settings_page.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/submitted_restaurants_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class ProfileHeaderTop extends StatelessWidget {
  const ProfileHeaderTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.user;

        final image = user?.photoUrl == null || user!.photoUrl!.isEmpty ? null : provider.user!.photoUrl!;

        return SliverAppBar(
          expandedHeight: context.height * 0.50,
          pinned: true,
          backgroundColor: context.theme.colorScheme.background,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProfilePictureScreen.id,
                      );
                    },
                    child: Hero(
                      tag: 'profilePic',
                      child: image != null
                          // ? Image.network(
                          //     image,
                          //     fit: BoxFit.cover,
                          //   )
                          ? CachedNetworkImage(
                              imageUrl: image,
                              // width: double.maxFinite,
                              fit: BoxFit.cover,

                              placeholder: (context, percentage) {
                                return const LoadingPage();
                              },
                              errorWidget: (context, error, child) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 150.0),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 400,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 150.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 400,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor: context.theme.cardTheme.color,
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: context.theme.iconTheme.color,
                  ),
                  surfaceTintColor: context.theme.cardTheme.color,
                  color: context.theme.cardTheme.color,
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  itemBuilder: (_) {
                    return [
                      if (user?.isAdmin ?? false)
                        PopupMenuItem<void>(
                          onTap: () => Navigator.of(context).pushNamed(
                            AddFoodProductScreen.id,
                            arguments: serviceLocator<FoodProductCubit>(),
                          ),
                          child: PopupItem(
                            title: 'Add New Product',
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.iconTheme.color,
                            ),
                          ),
                        ),
                      if (user?.isAdmin ?? false)
                        PopupMenuItem<void>(
                          onTap: () => Navigator.of(context).pushNamed(
                            ReportsScreen.id,
                            arguments: serviceLocator<FoodProductCubit>(),
                          ),
                          child: PopupItem(
                            title: 'Reports From Users',
                            icon: Icon(
                              Icons.report_outlined,
                              color: context.theme.iconTheme.color,
                            ),
                          ),
                        ),
                      if (context.userProvider.user?.isAdmin ?? false)
                        PopupMenuItem<void>(
                          onTap: () => Navigator.of(context).pushNamed(
                            SubmittedRestaurantsScreen.id,
                            arguments: serviceLocator<RestaurantsCubit>(),
                          ),
                          child: PopupItem(
                            title: 'Submitted Restaurants',
                            icon: Icon(
                              Icons.report_outlined,
                              color: context.theme.iconTheme.color,
                            ),
                          ),
                        ),
                      PopupMenuItem<void>(
                        onTap: () => Navigator.of(context).pushNamed(
                          SettingsPage.id,
                          arguments: serviceLocator<AuthBloc>(),
                        ),
                        child: PopupItem(
                          title: 'Settings',
                          icon: Icon(
                            Icons.settings_outlined,
                            color: context.theme.iconTheme.color,
                          ),
                        ),
                      ),
                      PopupMenuItem<void>(
                        height: 1,
                        padding: EdgeInsets.zero,
                        child: Divider(
                          height: 1,
                          color: Colors.grey.shade300,
                          endIndent: 10,
                          indent: 10,
                        ),
                      ),
                      PopupMenuItem<void>(
                        onTap: () async {
                          final navigator = Navigator.of(context);

                          context.savedProductsProvider.savedProductsList = null;
                          context.savedRestaurantsProvider.savedRestaurantsList = null;
                          context.restaurantsNearMeProvider.currentLocation = null;
                          context.restaurantsNearMeProvider.markers = null;
                          context.restaurantsNearMeProvider.restaurants = null;
                          context.userProvider.user = null;

                          await serviceLocator<FirebaseAuth>().signOut();
                          unawaited(
                            navigator.pushNamedAndRemoveUntil(
                              '/',
                              (route) => false,
                            ),
                          );
                        },
                        child: PopupItem(
                          title: 'Logout',
                          icon: Icon(
                            Icons.logout,
                            color: context.themeMode == ThemeMode.dark ? Colors.grey.shade700 : Colors.black,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: context.theme.cardTheme.color?.withOpacity(0.93),
                border: const Border(
                  right: BorderSide(color: Colors.black12),
                  left: BorderSide(color: Colors.black12),
                  top: BorderSide(color: Colors.black12),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
              ),
              child: Center(
                child: Text(
                  user?.name ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    // color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
