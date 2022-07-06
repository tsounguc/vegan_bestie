import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:sheveegan/logic/cubit/barcode_scanner_cubit.dart';
import 'package:sheveegan/presentation/router/app_router.dart';
import 'package:sheveegan/themes/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BarcodeScannerCubit>(
      create: (context) => BarcodeScannerCubit(),
      child: Sizer(
        builder: (context, orientation, deviceType) =>
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
                onGenerateRoute: AppRouter.onGenerateRoute),
      ),
    );
  }
}
