import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/core/utils/strings.dart';
import 'package:sheveegan/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';
import 'package:sheveegan/features/restaurants/presentation/map_cubit/map_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurant_cubit/restaurant_details_cubit.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_product_home_page.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';
import 'package:sheveegan/features/search/presentation/search_bloc/search_bloc.dart';

import 'package:sheveegan/home_page.dart';
import 'package:sheveegan/themes/app_theme.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await setUpServices();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ScanProductCubit>(
          create: (context) => serviceLocator<ScanProductCubit>(),
        ),
        BlocProvider<GeolocationBloc>(
          create: (context) => GeolocationBloc(),
        ),
        BlocProvider<RestaurantsBloc>(
          create: (context) => serviceLocator<RestaurantsBloc>(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<RestaurantDetailsCubit>(
          create: (context) => RestaurantDetailsCubit(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          debugShowCheckedModeBanner: false,
          title: Strings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: const ScanProductHomePage(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          // onUnknownRoute: AppRouter.onUnknownRoute,
        ),
      ),
    );
  }
}
