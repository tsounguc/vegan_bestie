import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/screens/product_screens/product_not_found.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/scan_product_home_page.dart';
import 'package:sheveegan/features/scan_product/presentation/pages/select_incorrect_information.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/auth/presentation/pages/forgot_password.dart';
import '../features/auth/presentation/pages/registration_page.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/restaurants/presentation/pages/restaurants_home_page.dart';
import '../features/scan_product/presentation/pages/report_issue_page.dart';
import '../features/scan_product/presentation/pages/scan_results_page.dart';
import '../features/social_network/presentation/pages/edit_profile_page.dart';
import '../features/social_network/presentation/pages/profile_page.dart';
import '../home_page.dart';
import '../features/auth/presentation/pages/login_page.dart';

class AppRouter {
  final String productFound = 'productdound';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => HomePage());
      case AuthPage.id:
        return MaterialPageRoute(builder: (context) => AuthPage());
      case LoginPage.id:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case ProfilePage.id:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case EditProfilePage.id:
        return MaterialPageRoute(builder: (context) => EditProfilePage());
      case RegistrationPage.id:
        return MaterialPageRoute(builder: (context) => RegistrationPage());
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
      case ReportIssuePage.id:
        return MaterialPageRoute(builder: (context) => ReportIssuePage());
      case SelectIncorrectInformation.id:
        return MaterialPageRoute(builder: (context) => SelectIncorrectInformation());
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
