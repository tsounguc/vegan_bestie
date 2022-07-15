import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/data/providers/open_food_facts_api_provider.dart';
import 'package:sheveegan/logic/cubit/barcode_scanner_cubit.dart';
import 'package:sheveegan/logic/cubit/product_fetch_cubit.dart';
import 'package:sheveegan/presentation/router/app_router.dart';
import 'package:sheveegan/themes/app_theme.dart';

import 'data/repositoryLayer/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (BuildContext context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final OpenFoodFactsApiProvider openFoodFactsApiProvider = OpenFoodFactsApiProvider();

  MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BarcodeScannerCubit>(
          create: (context) => BarcodeScannerCubit(),
        ),
        BlocProvider<ProductFetchCubit>(
          create: (context) =>
              ProductFetchCubit(
                repository: Repository(
                    openFoodFactApiProvider: openFoodFactsApiProvider
                ),
              ),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) =>
            MaterialApp(
              useInheritedMediaQuery: true,
              builder: DevicePreview.appBuilder,
              locale: DevicePreview.locale(context),
              debugShowCheckedModeBanner: false,
              title: "SheVegan Home",
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
              initialRoute: AppRouter.home,
              onGenerateRoute: AppRouter.onGenerateRoute,
              // onUnknownRoute: AppRouter.onUnknownRoute,
            ),
      ),
    );
  }
}
