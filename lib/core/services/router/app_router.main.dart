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

              // if (context.currentLocation == null) {
              //   debugPrint('if currentLocation is null loadGeoLocation from appRouter');
              //   serviceLocator<RestaurantsCubit>().loadGeoLocation().then(
              //     (value) {
              //       if (context.currentUser?.savedRestaurantsIds.length != context.savedRestaurantsList?.length) {
              //         final savedRestaurantsIds = context.currentUser?.savedRestaurantsIds ?? [];
              //         serviceLocator<RestaurantsCubit>().getSavedRestaurants(savedRestaurantsIds);
              //       }
              //     },
              //   );
              // }

              return MultiBlocProvider(providers: [
                BlocProvider(
                  create: (_) => serviceLocator<RestaurantsCubit>(),
                ),
                BlocProvider(
                  create: (_) => serviceLocator<FoodProductCubit>(),
                ),
              ], child: const Dashboard());
            } else {
              return BlocProvider(
                create: (_) => serviceLocator<AuthBloc>(),
                child: const SignInScreen(),
              );
            }
          },
          settings: settings,
        );
      // case Dashboard.id:
      //   return _pageBuilder(
      //     (_) => const Dashboard(),
      //     settings: settings,
      //   );
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
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const EditProfileScreen(),
          ),
          settings: settings,
        );
      case DisplayScreen.id:
        return _pageBuilder(
          (_) => const DisplayScreen(),
          settings: settings,
        );

      case ChangePasswordScreen.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const ChangePasswordScreen(),
          ),
          settings: settings,
        );

      case SettingsPage.id:
        return _pageBuilder(
          (_) => BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
            child: const SettingsPage(),
          ),
          settings: settings,
        );

      case ReportsScreen.id:
        return _pageBuilder(
          (_) => BlocProvider<FoodProductCubit>.value(
            value: serviceLocator<FoodProductCubit>(),
            child: const ReportsScreen(),
          ),
          settings: settings,
        );

      case SubmittedRestaurantsScreen.id:
        return _pageBuilder(
          (_) => BlocProvider<RestaurantsCubit>.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: const SubmittedRestaurantsScreen(),
          ),
          settings: settings,
        );

      case ScanResultsPage.id:
        return _pageBuilder(
          (_) => BlocProvider<FoodProductCubit>.value(
            value: serviceLocator<FoodProductCubit>(),
            child: const ScanResultsPage(),
          ),
          settings: settings,
        );
      case RestaurantDetailsPage.id:
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: RestaurantDetailsPage(
              restaurant: settings.arguments! as Restaurant,
            ),
          ),
          settings: settings,
        );
      case ProductFoundPage.id:
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: ProductFoundPage(
              product: settings.arguments! as FoodProduct,
            ),
          ),
          settings: settings,
        );
      case RestaurantReviewScreen.id:
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: RestaurantReviewScreen(
              restaurant: settings.arguments! as Restaurant,
            ),
          ),
          settings: settings,
        );
      case AllSavedProductsPage.id:
        return _pageBuilder(
          (_) => const AllSavedProductsPage(),
          settings: settings,
        );
      case LoadingPage.id:
        return _pageBuilder(
          (_) => const LoadingPage(),
          settings: settings,
        );
      case AllSavedRestaurantsPage.id:
        return _pageBuilder(
          (_) => BlocProvider<RestaurantsCubit>.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: const AllSavedRestaurantsPage(),
          ),
          settings: settings,
        );

      case EditRestaurantReviewScreen.id:
        final args = settings.arguments! as EditRestaurantScreenArguments;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<RestaurantsCubit>(),
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

      case UpdateRestaurantScreen.id:
        final args = settings.arguments! as UpdateRestaurantScreenArguments;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: UpdateRestaurantScreen(
              restaurant: args.restaurant,
            ),
          ),
          settings: settings,
        );

      case AddFoodProductScreen.id:
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: const AddFoodProductScreen(),
          ),
          settings: settings,
        );

      case AddRestaurantScreen.id:
        final args = settings.arguments as RestaurantModel?;
        return _pageBuilder(
          (context) => BlocProvider.value(
            value: serviceLocator<RestaurantsCubit>(),
            child: AddRestaurantScreen(
              restaurant: args,
            ),
          ),
          settings: settings,
        );

      case FoodProductReportScreen.id:
        final args = settings.arguments as FoodProductModel?;
        return _pageBuilder(
          (_) => BlocProvider.value(
            value: serviceLocator<FoodProductCubit>(),
            child: FoodProductReportScreen(product: args),
          ),
          settings: settings,
        );

      default:
        return _pageBuilder(
          (_) => const PageNotFound(),
          settings: settings,
        );
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
  final Restaurant restaurant;
}

class UpdateFoodProductPageArguments {
  const UpdateFoodProductPageArguments(this.title, this.product);

  final String title;
  final FoodProduct? product;
}

class UpdateRestaurantScreenArguments {
  const UpdateRestaurantScreenArguments(this.title, this.restaurant);

  final String title;
  final Restaurant? restaurant;
}
