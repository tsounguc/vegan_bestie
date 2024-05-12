import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/constants.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/food_product/presentation/pages/add_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/profile/presentation/refactors/profile_header.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_products_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_restaurants_pages.dart';
import 'package:sheveegan/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/reports_screen.dart';
import 'package:sheveegan/features/profile/presentation/widgets/product_card.dart';
import 'package:sheveegan/features/profile/presentation/widgets/restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Consumer<SavedProductsProvider>(
          builder: (_, productsProvider, __) {
            return Consumer<SavedRestaurantsProvider>(
              builder: (_, restaurantsProvider, __) {
                return Consumer<UserProvider>(
                  builder: (_, userProvider, __) {
                    final user = userProvider.user;
                    final image =
                        user?.photoUrl == null || user!.photoUrl!.isEmpty ? null : userProvider.user!.photoUrl!;
                    return CustomScrollView(
                      controller: scrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          expandedHeight: context.height * 0.50,
                          pinned: true,
                          backgroundColor: Colors.white,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              children: [
                                Positioned.fill(
                                  child: image != null
                                      ? Image.network(
                                          image,
                                          // width: double.maxFinite,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(kUserIconPath),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.black,
                                  ),
                                  surfaceTintColor: Colors.white,
                                  offset: const Offset(0, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  itemBuilder: (_) {
                                    return [
                                      PopupMenuItem<void>(
                                        onTap: () => Navigator.of(context).pushNamed(
                                          EditProfileScreen.id,
                                          arguments: context.read<AuthBloc>(),
                                        ),
                                        child: const PopupItem(
                                          title: 'Edit Profile',
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: Color(0xFF757C8E),
                                          ),
                                        ),
                                      ),
                                      if (context.userProvider.user?.isAdmin ?? false)
                                        PopupMenuItem<void>(
                                          onTap: () => Navigator.of(context).pushNamed(
                                            AddFoodProductScreen.id,
                                            arguments: context.read<FoodProductCubit>(),
                                          ),
                                          child: const PopupItem(
                                            title: 'Add New Product',
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: Color(0xFF757C8E),
                                            ),
                                          ),
                                        ),
                                      if (context.userProvider.user?.isAdmin ?? false)
                                        PopupMenuItem<void>(
                                          onTap: () => Navigator.of(context).pushNamed(
                                            ReportsScreen.id,
                                            arguments: context.read<FoodProductCubit>(),
                                          ),
                                          child: const PopupItem(
                                            title: 'Reports',
                                            icon: Icon(
                                              Icons.report_outlined,
                                              color: Color(0xFF757C8E),
                                            ),
                                          ),
                                        ),
                                      // const PopupMenuItem<void>(
                                      //   // onTap: () => context.push(const Placeholder()),
                                      //   child: PopupItem(
                                      //     title: 'Notifications',
                                      //     icon: Icon(
                                      //       Icons.notifications,
                                      //       color: Color(0xFF757C8E),
                                      //     ),
                                      //   ),
                                      // ),
                                      // const PopupMenuItem<void>(
                                      //   // onTap: () => context.push(const Placeholder()),
                                      //   child: PopupItem(
                                      //     title: 'Help',
                                      //     icon: Icon(
                                      //       Icons.help_outline_outlined,
                                      //       color: Color(0xFF757C8E),
                                      //     ),
                                      //   ),
                                      // ),
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
                                          await serviceLocator<FirebaseAuth>().signOut();
                                          context.savedProductsProvider.savedProductsList = null;
                                          context.savedRestaurantsProvider.savedRestaurantsList = null;

                                          unawaited(
                                            navigator.pushNamedAndRemoveUntil(
                                              '/',
                                              (route) => false,
                                            ),
                                          );
                                        },
                                        child: const PopupItem(
                                          title: 'Logout',
                                          icon: Icon(
                                            Icons.logout,
                                            color: Colors.black,
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
                                color: Colors.white.withOpacity(0.95),
                                border: const Border(
                                  right: BorderSide(color: Colors.black12),
                                  left: BorderSide(color: Colors.black12),
                                  top: BorderSide(color: Colors.black12),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25.r),
                                  topLeft: Radius.circular(25.r),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  context.currentUser!.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ProfileHeader(),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ).copyWith(
                                  top: 5.h,
                                  bottom: 5.h,
                                ),
                                child: SectionHeader(
                                  sectionTitle: 'Saved Food Products',
                                  seeAll: productsProvider.savedProductsList != null &&
                                      productsProvider.savedProductsList!.length >= 4,
                                  onSeeAll: () => Navigator.of(context).pushNamed(
                                    AllSavedProductsPage.id,
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: productsProvider.savedProductsList == null
                                        ? [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 45,
                                                horizontal: 35,
                                              ),
                                              child: CircularProgressIndicator(),
                                            ),
                                          ]
                                        : productsProvider.savedProductsList!.isEmpty
                                            ? [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 45,
                                                    horizontal: 35,
                                                  ),
                                                  child: Text(
                                                    'Food Products will be here '
                                                    'once saved',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey.shade500,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                            : productsProvider.savedProductsList!
                                                .take(4)
                                                .map(
                                                  (product) => Padding(
                                                    padding: const EdgeInsets.only(right: 16),
                                                    child: ProductCard(
                                                      product: product,
                                                      onTap: () => Navigator.of(
                                                        context,
                                                      ).pushNamed(
                                                        ProductFoundPage.id,
                                                        arguments: product,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(
                                  top: 5.h,
                                  bottom: 5.h,
                                ),
                                child: SectionHeader(
                                  sectionTitle: 'Saved Restaurants',
                                  seeAll: restaurantsProvider.savedRestaurantsList != null &&
                                      restaurantsProvider.savedRestaurantsList!.length >= 4,
                                  onSeeAll: () => Navigator.of(context).pushNamed(
                                    AllSavedRestaurantsPage.id,
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: restaurantsProvider.savedRestaurantsList == null
                                        ? [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 45,
                                                horizontal: 35,
                                              ),
                                              child: CircularProgressIndicator(),
                                            ),
                                          ]
                                        : restaurantsProvider.savedRestaurantsList!.isEmpty
                                            ? [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 50,
                                                    horizontal: 35,
                                                  ),
                                                  child: Text(
                                                    'Restaurants will be here once saved',
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.grey.shade500,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                            : restaurantsProvider.savedRestaurantsList!
                                                .take(4)
                                                .map(
                                                  (restaurant) => Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 16,
                                                    ),
                                                    child: RestaurantCard(
                                                      restaurant: restaurant,
                                                      onTap: () => Navigator.of(context).pushNamed(
                                                        RestaurantDetailsPage.id,
                                                        arguments: restaurant,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
