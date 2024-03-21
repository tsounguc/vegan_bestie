part of 'package:sheveegan/core/services/router/app_router.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => const HomePage());
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
        return MaterialPageRoute(
          builder: (context) => const SelectIncorrectInformation(),
        );
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
