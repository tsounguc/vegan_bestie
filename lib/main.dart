import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/strings.dart';
import 'core/service_locator.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';
import 'features/restaurants/presentation/map_cubit/map_cubit.dart';
import 'features/restaurants/presentation/restaurant_cubit/restaurant_details_cubit.dart';
import 'features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'features/scan_product/presentation/barcode_scanner_cubit/barcode_scanner_cubit.dart';
import 'features/scan_product/presentation/fetch_product_cubit/product_fetch_cubit.dart';
import 'features/search/presentation/search_bloc/search_bloc.dart';
import 'home_page.dart';
import 'router/app_router.dart';
import 'themes/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  setUpServices();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key});

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
        BlocProvider<BarcodeScannerCubit>(
          create: (context) => BarcodeScannerCubit(),
        ),
        BlocProvider<ProductFetchCubit>(
          create: (context) => ProductFetchCubit(),
        ),
        BlocProvider<GeolocationBloc>(
          create: (context) => GeolocationBloc(),
        ),
        BlocProvider<RestaurantsBloc>(
          create: (context) => RestaurantsBloc(),
        ),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<RestaurantDetailsCubit>(
          create: (context) => RestaurantDetailsCubit(),
        )
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          debugShowCheckedModeBanner: false,
          title: Strings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: HomePage(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          // onUnknownRoute: AppRouter.onUnknownRoute,
        ),
      ),
    );
  }
}
