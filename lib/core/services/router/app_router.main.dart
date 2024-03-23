part of 'package:sheveegan/core/services/router/app_router.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            if (serviceLocator<FirebaseAuth>().currentUser != null) {
              final user = serviceLocator<FirebaseAuth>().currentUser!;
              final userModel = UserModel(
                uid: user.uid,
                email: user.email ?? '',
                name: user.displayName ?? '',
              );
              context.userProvider.initUser(userModel);
              return const HomePage();
            } else {
              return const SignInScreen();
            }
          },
        );
      case HomePage.id:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case SignInScreen.id:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case WelcomePage.id:
        return MaterialPageRoute(builder: (context) => const WelcomePage());
      case ForgotPasswordScreen.id:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
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
