import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/features/profile/presentation/refactors/profile_header_bottom.dart';
import 'package:sheveegan/features/profile/presentation/refactors/profile_header_top.dart';
import 'package:sheveegan/features/profile/presentation/refactors/saved_foods_section.dart';
import 'package:sheveegan/features/profile/presentation/refactors/saved_restaurants_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Scaffold(
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
                  SizedBox(height: 35.h),
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
    );
  }
}
