import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/screens/error/page_not_found.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/welcome_page.dart';
import 'package:sheveegan/features/dashboard/presentation/views/dashboard.dart';
import 'package:sheveegan/features/food_product//presentation/pages/update_food_product_screen.dart';
import 'package:sheveegan/features/food_product/data/models/food_product_model.dart';
import 'package:sheveegan/features/food_product/domain/entities/food_product.dart';
import 'package:sheveegan/features/food_product/presentation/pages/add_food_product_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/food_product_image_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/food_product_report_screen.dart';
import 'package:sheveegan/features/food_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/food_product/presentation/pages/scan_results_page.dart';
import 'package:sheveegan/features/food_product/presentation/scan_product_cubit/food_product_cubit.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_products_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/all_saved_restaurants_pages.dart';
import 'package:sheveegan/features/profile/presentation/screens/change_email_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/change_password_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/contact_support_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/display_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/profile_picture_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/reports_screen.dart';
import 'package:sheveegan/features/profile/presentation/screens/settings_page.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';
import 'package:sheveegan/features/restaurants/presentation/map_cubit/map_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/add_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/edit_restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_picture_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_review_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/submitted_restaurants_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/update_restaurant_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_cubit/restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/search_restaurants_cubit/search_restaurants_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/user_location_cubit/user_location_cubit.dart';

part 'package:sheveegan/core/services/router/app_router.main.dart';
