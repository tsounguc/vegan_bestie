part of 'package:sheveegan/core/services/router/app_router.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return _pageBuilder(
          (context) {
            if (serviceLocator<FirebaseAuth>().currentUser != null) {
              // get user info from firebase
              final user = serviceLocator<FirebaseAuth>().currentUser!;
              // create userModel with user info
              final userModel = UserModel(
                uid: user.uid,
                email: user.email ?? '',
                name: user.displayName ?? '',
              );
              // store user model in user provider
              context.userProvider.initUser(userModel);

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => serviceLocator<ScanProductCubit>(),
                  ),
                  BlocProvider(
                    create: (_) => serviceLocator<RestaurantsBloc>(),
                  ),
                  BlocProvider(
                    create: (_) => serviceLocator<AuthBloc>(),
                  ),
                ],
                child: const HomePage(),
              );
            } else {
              return BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
                child: const SignInScreen(),
              );
            }
          },
          settings: settings,
        );
      case HomePage.id:
        return _pageBuilder(
          (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => serviceLocator<ScanProductCubit>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<RestaurantsBloc>(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
              ),
            ],
            child: const HomePage(),
          ),
          settings: settings,
        );
      case SignInScreen.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const SignInScreen(),
          ),
          settings: settings,
        );
      case SignUpScreen.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const SignUpScreen(),
          ),
          settings: settings,
        );
      case ForgotPasswordScreen.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const ForgotPasswordScreen(),
          ),
          settings: settings,
        );
      case WelcomePage.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const WelcomePage(),
          ),
          settings: settings,
        );

      case EditProfileScreen.id:
        return _pageBuilder(
          (_) => BlocProvider<AuthBloc>.value(
            value: settings.arguments! as AuthBloc,
            child: const EditProfileScreen(),
          ),
          settings: settings,
        );

      case ScanResultsPage.id:
        return _pageBuilder(
          (_) => BlocProvider<ScanProductCubit>.value(
            value: settings.arguments! as ScanProductCubit,
            child: const ScanResultsPage(),
          ),
          settings: settings,
        );
      case RestaurantDetailsPage.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<RestaurantsBloc>(),
            child: RestaurantDetailsPage(
              restaurantDetails: settings.arguments! as RestaurantDetails,
            ),
          ),
          settings: settings,
        );
      case ProductFoundPage.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<ScanProductCubit>(),
            child: ProductFoundPage(
              product: settings.arguments! as FoodProduct,
            ),
          ),
          settings: settings,
        );

      case AllSavedProductsPage.id:
        return _pageBuilder(
          (_) => const AllSavedProductsPage(),
          settings: settings,
        );

      case AllSavedRestaurantsPage.id:
        return _pageBuilder(
          (_) => const AllSavedRestaurantsPage(),
          settings: settings,
        );
      // return MaterialPageRoute(
      //   builder: (context) => const ProductFoundPageTwo(),
      // );
      // case ProductFoundPageTwo.id:
      //   return MaterialPageRoute(
      //     builder: (context) => const ProductFoundPageTwo(),
      //   );

      default:
        throw Exception('Route not found!');
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const ProductNotFoundPage(),
    );
  }

  static PageRouteBuilder<dynamic> _pageBuilder(
    Widget Function(BuildContext context) page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      pageBuilder: (context, _, __) => page(context),
    );
  }
}
