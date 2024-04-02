import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:sheveegan/features/auth/presentation/pages/welcome_page.dart';
import 'package:sheveegan/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/componets/restaurant_details_page.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/product_found_page.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_results_page.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';
import 'package:sheveegan/home_page.dart';

part 'package:sheveegan/core/services/router/app_router.main.dart';
