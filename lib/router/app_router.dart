import 'package:flutter/material.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_product_home_page.dart';

import '../core/product_not_found.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/auth/presentation/pages/forgot_password.dart';
import '../features/auth/presentation/pages/sign_up.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/restaurants/presentation/pages/restaurants_home_page.dart';
import '../features/scan_product/presentation/pages/scan_results_page.dart';
import '../home_page.dart';
import '../features/auth/presentation/pages/login_page.dart';

class AppRouter {
  final String productFound = 'productdound';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomePage.id:
        debugPrint("$arguments");
        return MaterialPageRoute(builder: (context) => HomePage());
      case AuthPage.id:
        debugPrint("$arguments");
        return MaterialPageRoute(builder: (context) => AuthPage());
      case LoginPage.id:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case SignUpPage.id:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case WelcomePage.id:
        return MaterialPageRoute(builder: (context) => WelcomePage());
      case ForgotPasswordPage.id:
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
      case RestaurantsHomePage.id:
        return MaterialPageRoute(builder: (context) => RestaurantsHomePage());
      case ScanProductHomePage.id:
        return MaterialPageRoute(builder: (context) => ScanProductHomePage());
      case ScanResultsPage.id:
        return MaterialPageRoute(builder: (context) => ScanResultsPage());
      default:
        throw Exception('Route not found!');
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => ProductNotFoundPage(),
    );
  }
}
