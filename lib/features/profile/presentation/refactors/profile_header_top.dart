import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/common/widgets/popup_item.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/food_product/presentation/pages/add_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
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
        // final user = provider.user;
        // final image = user?.photoUrl == null || user!.photoUrl!.isEmpty ? null : provider.user!.photoUrl!;
        // print(provider.user?.photoUrl);
        // final image = Image.network(
        //   provider.user?.photoUrl ?? MediaResources.user,
        //   fit: BoxFit.cover,
        //   errorBuilder: (_, exception, stackTrace) {
        //     return ErrorWidget(exception.toString());
        //   },
        // );
        // image.image.resolve(ImageConfiguration.empty).addListener(
        //       ImageStreamListener(
        //         (_, __) {
        //           /* You can do something when the image is loaded. */
        //         },
        //         onError: (_, __) {
        //           // Evict the object from the cache to retry to fetch it the next
        //           // time this widget is built.
        //           imageCache.evict(image.image);
        //         },
        //       ),
        //     );
        return SliverAppBar(
          expandedHeight: context.height * 0.50,
          pinned: true,
          backgroundColor: context.theme.colorScheme.background,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: provider.user?.photoUrl != null && provider.user!.photoUrl!.isNotEmpty
                      // ? image
                      ? CachedNetworkImage(
                          imageUrl: provider.user!.photoUrl ?? '',
                          // width: double.maxFinite,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, child) {
                            return Image.asset(MediaResources.user);
                          },
                        )
                      : Image.asset(MediaResources.user),
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
                      if (context.userProvider.user?.isAdmin ?? false)
                        PopupMenuItem<void>(
                          onTap: () => Navigator.of(context).pushNamed(
                            AddFoodProductScreen.id,
                            arguments: context.read<FoodProductCubit>(),
                          ),
                          child: PopupItem(
                            title: 'Add New Product',
                            icon: Icon(
                              Icons.edit_outlined,
                              color: context.theme.iconTheme.color,
                            ),
                          ),
                        ),
                      if (context.userProvider.user?.isAdmin ?? false)
                        PopupMenuItem<void>(
                          onTap: () => Navigator.of(context).pushNamed(
                            ReportsScreen.id,
                            arguments: context.read<FoodProductCubit>(),
                          ),
                          child: PopupItem(
                            title: 'Reports',
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
                            arguments: context.read<RestaurantsCubit>(),
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
                          arguments: context.read<AuthBloc>(),
                        ),
                        child: PopupItem(
                          title: 'Settings',
                          icon: Icon(
                            Icons.settings_outlined,
                            color: context.theme.iconTheme.color,
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
                          if (context.mounted) {
                            context.savedProductsProvider.savedProductsList = null;
                            context.savedRestaurantsProvider.savedRestaurantsList = null;
                          }
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
                            color: context.themeModeProvider.themeMode == ThemeMode.dark
                                ? Colors.grey.shade700
                                : Colors.black,
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
                  context.currentUser!.name,
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
