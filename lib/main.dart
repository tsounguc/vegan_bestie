import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/service_locator.dart';
import 'package:sheveegan/core/services/restaurants_services/restaurants_service.dart';
import 'package:sheveegan/core/services/food_facts_services/food_facts_api_service.dart';
import 'package:sheveegan/features/restaurants/presentation/geolocation_bloc/geolocation_bloc.dart';
import 'package:sheveegan/features/search/presentation/search_bloc/search_bloc.dart';
import 'package:sheveegan/features/scan_product/presentation/barcode_scanner_cubit/barcode_scanner_cubit.dart';
import 'package:sheveegan/features/scan_product/presentation/fetch_product_cubit/product_fetch_cubit.dart';
import 'package:sheveegan/home_page.dart';
import 'package:sheveegan/themes/app_theme.dart';
import 'data/repositoryLayer/repository.dart';
import 'features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/auth/presentation/pages/welcome_page.dart';
import 'features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'router/app_router.dart';

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
  final Repository repository = Repository(
    openFoodFactApiProvider: OpenFoodFactsApiServiceImpl(),
    yelpFusionApiProvider: YelpFusionRestaurantsApiServiceImpl(),
    // googlePlacesApiProvider: GooglePlacesApiProvider(),
    // restaurantsApiProvider: RestaurantsApiProvider(),
  );
  User? currentUser;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (currentUser != user) {
        currentUser = user;
      }
    });
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
        ),BlocProvider<GeolocationBloc>(
          create: (context) => GeolocationBloc(),
        ),
        BlocProvider<RestaurantsBloc>(
          create: (context) => RestaurantsBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(repository: repository),
        ),

      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          debugShowCheckedModeBanner: false,
          title: "SheVegan Home",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: AuthPage(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          // onUnknownRoute: AppRouter.onUnknownRoute,
        ),
      ),
    );
  }
}
