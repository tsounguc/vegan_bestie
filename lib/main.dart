import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sheveegan/core/common/app/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/core/common/app/providers/food_product_reports_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/themes/app_theme.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (!kDebugMode) {
    debugPrint('Not In Debug');
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
    );
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  }
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SavedProductsProvider()),
        ChangeNotifierProvider(create: (_) => SavedRestaurantsProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => FoodProductReportsProvider()),
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
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
