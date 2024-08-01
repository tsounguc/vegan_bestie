import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/common/widgets/section_header.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/food_product/presentation/pages/add_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/profile/presentation/refactors/profile_header_bottom.dart';
import 'package:sheveegan/features/profile/presentation/refactors/profile_header_top.dart';
import 'package:sheveegan/features/profile/presentation/refactors/saved_foods_section.dart';
import 'package:sheveegan/features/profile/presentation/refactors/saved_restaurants_section.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_products_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_restaurants_pages.dart';
import 'package:sheveegan/features/profile/presentation/screens/reports_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/settings_page.dart';
import 'package:sheveegan/features/profile/presentation/widgets/product_card.dart';
import 'package:sheveegan/features/profile/presentation/widgets/restaurant_card.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/submitted_restaurants_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return MultiBlocListener(
      listeners: [
        BlocListener<FoodProductCubit, FoodProductState>(
          listener: (context, state) {
            if (state is SavedProductsListFetched) {
              context.savedProductsProvider.savedProductsList = state.savedProductsList;
            }
            if (state is ReportsFetched) {
              context.reportsProvider.reports = state.reports;
            }
          },
        ),
        BlocListener<RestaurantsCubit, RestaurantsState>(
          listener: (context, state) {
            if (state is SavedRestaurantsListFetched) {
              context.savedRestaurantsProvider.savedRestaurantsList = state.savedRestaurantsList;
            }
          },
        ),
      ],
      child: Scaffold(
        // backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          controller: scrollController,
          child: CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: [
              // has profile image and user name
              const ProfileHeaderTop(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // has bio and edit button
                    const ProfileHeaderBottom(),
                    SizedBox(height: 10.h),
                    const SavedFoodsSection(),
                    SizedBox(height: 20.h),
                    const SavedRestaurantsSection(),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
