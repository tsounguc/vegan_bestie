import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_product_home_page.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/select_incorrect_information.dart';
import '../../../home_page.dart';
import '../../../features/auth/presentation/pages/auth_page.dart';
import '../../../features/auth/presentation/pages/forgot_password.dart';
import '../../../features/auth/presentation/pages/registration_page.dart';
import '../../../features/auth/presentation/pages/welcome_page.dart';
import '../../../features/restaurants/presentation/pages/restaurants_home_page.dart';
import '../../../features/scan_product/presentation/pages/report_issue_page.dart';
import '../../../features/scan_product/presentation/pages/scan_results_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';

class AppRouter {
  final String productFound = 'productdound';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AuthPage.id:
        return MaterialPageRoute(builder: (context) => const AuthPage());
      case LoginPage.id:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case RegistrationPage.id:
        return MaterialPageRoute(builder: (context) => const RegistrationPage());
      case WelcomePage.id:
        return MaterialPageRoute(builder: (context) => const WelcomePage());
      case ForgotPasswordPage.id:
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
      case RestaurantsHomePage.id:
        return MaterialPageRoute(builder: (context) => RestaurantsHomePage());
      case ScanProductHomePage.id:
        return MaterialPageRoute(builder: (context) => const ScanProductHomePage());
      case ScanResultsPage.id:
        return MaterialPageRoute(builder: (context) => const ScanResultsPage());
      case ReportIssuePage.id:
        return MaterialPageRoute(builder: (context) => const ReportIssuePage());
      case SelectIncorrectInformation.id:
        return MaterialPageRoute(builder: (context) => const SelectIncorrectInformation(),);
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
