import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheveegan/core/common/app/providers/food_product_reports_provider.dart';
import 'package:sheveegan/core/common/app/providers/notifications_notifier.dart';
import 'package:sheveegan/core/common/app/providers/restaurants_near_me_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_products_provider.dart';
import 'package:sheveegan/core/common/app/providers/saved_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/submitted_restaurants_provider.dart';
import 'package:sheveegan/core/common/app/providers/theme_mode_provider.dart';
import 'package:sheveegan/core/common/app/providers/user_provider.dart';
import 'package:sheveegan/core/resources/strings.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/core/services/service_locator.dart';
import 'package:sheveegan/features/dashboard/presentation/providers/bottom_navigation_bar_provider.dart';
import 'package:sheveegan/themes/app_theme.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpServices();
  final themeModePreference = ThemeModePreference();
  final useDeviceSettings = await themeModePreference.getUseDeviceSettings();
  final isDarkMode = await themeModePreference.getDarkTheme();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  if (!kDebugMode) {
    debugPrint('Not In Debug');
    await FirebaseAppCheck.instance.activate(
        // androidProvider: AndroidProvider.playIntegrity,
        // appleProvider: AppleProvider.deviceCheck,
        );
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  }

  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => MyApp(
        useDeviceSettings: useDeviceSettings,
        isDarkMode: isDarkMode,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    required this.useDeviceSettings,
    required this.isDarkMode,
    super.key,
  });

  final bool useDeviceSettings;
  final bool isDarkMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // context.themeModeProvider.initThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NotificationsNotifier(serviceLocator<SharedPreferences>()),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider.value(value: SavedProductsProvider()),
        ChangeNotifierProvider.value(value: SavedRestaurantsProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider.value(value: FoodProductReportsProvider()),
        ChangeNotifierProvider.value(value: RestaurantsNearMeProvider()),
        ChangeNotifierProvider.value(value: SubmittedRestaurantsProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeModeProvider(
            useDeviceSettings: widget.useDeviceSettings,
            isDarkMode: widget.isDarkMode,
          ),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => Consumer<ThemeModeProvider>(
          builder: (_, provider, __) {
            return MaterialApp(
              builder: DevicePreview.appBuilder,
              locale: DevicePreview.locale(context),
              debugShowCheckedModeBanner: false,
              title: Strings.appTitle,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: provider.themeMode,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
