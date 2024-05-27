part of 'package:sheveegan/core/services/router/app_router.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
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
                    create: (_) => serviceLocator<FoodProductCubit>(),
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
                create: (_) => serviceLocator<FoodProductCubit>(),
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

      case SettingsPage.id:
        return _pageBuilder(
          (_) => BlocProvider<AuthBloc>(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const SettingsPage(),
          ),
          settings: settings,
        );

      case ReportsScreen.id:
        return _pageBuilder(
          (_) => BlocProvider<FoodProductCubit>.value(
            value: settings.arguments! as FoodProductCubit,
            child: const ReportsScreen(),
          ),
          settings: settings,
        );

      case ScanResultsPage.id:
        return _pageBuilder(
          (_) => BlocProvider<FoodProductCubit>.value(
            value: settings.arguments! as FoodProductCubit,
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
            create: (_) => serviceLocator<FoodProductCubit>(),
            child: ProductFoundPage(
              product: settings.arguments! as FoodProduct,
            ),
          ),
          settings: settings,
        );
      case RestaurantReviewScreen.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<RestaurantsBloc>(),
            child: RestaurantReviewScreen(
              restaurantDetails: settings.arguments! as RestaurantDetails,
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
          (_) => BlocProvider<RestaurantsBloc>.value(
            value: serviceLocator<RestaurantsBloc>(),
            child: const AllSavedRestaurantsPage(),
          ),
          settings: settings,
        );

      case EditRestaurantReviewScreen.id:
        final args = settings.arguments! as EditRestaurantScreenArguments;
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<RestaurantsBloc>(),
            child: EditRestaurantReviewScreen(
              review: args.review,
              restaurant: args.restaurant,
            ),
          ),
          settings: settings,
        );

      case UpdateFoodProductScreen.id:
        final args = settings.arguments! as UpdateFoodProductPageArguments;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: UpdateFoodProductScreen(
              title: args.title,
              product: args.product,
            ),
          ),
          settings: settings,
        );

      case AddFoodProductScreen.id:
        final args = settings.arguments! as FoodProductCubit;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: const AddFoodProductScreen(),
          ),
          settings: settings,
        );

      case FoodProductReportScreen.id:
        final args = settings.arguments! as FoodProductModel?;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: FoodProductReportScreen(product: args),
          ),
          settings: settings,
        );

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

class EditRestaurantScreenArguments {
  const EditRestaurantScreenArguments(this.review, this.restaurant);

  final RestaurantReview review;
  final RestaurantDetails restaurant;
}

class UpdateFoodProductPageArguments {
  const UpdateFoodProductPageArguments(this.title, this.product);

  final String title;
  final FoodProduct? product;
}
