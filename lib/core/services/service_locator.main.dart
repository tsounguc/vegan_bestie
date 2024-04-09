part of 'service_locator.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initAuth();
  await _initScan();
  await _initRestaurants();
}

Future<void> _initAuth() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => AuthBloc(
        signInWithEmailAndPassword: serviceLocator(),
        createUserAccount: serviceLocator(),
        forgotPassword: serviceLocator(),
        updateUser: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => SignInWithEmailAndPassword(serviceLocator()))
    ..registerLazySingleton(() => CreateUserAccount(serviceLocator()))
    ..registerLazySingleton(() => ForgotPassword(serviceLocator()))
    ..registerLazySingleton(() => UpdateUser(serviceLocator()))
    // Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Data Sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: serviceLocator(),
        cloudStoreClient: serviceLocator(),
        dbClient: serviceLocator(),
      ),
    )
    // External dependencies
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initScan() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => ScanProductCubit(
        scanBarcode: serviceLocator(),
        fetchProduct: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ScanBarcode(serviceLocator()))
    ..registerLazySingleton(() => FetchProduct(serviceLocator()))
    // Repositories
    ..registerLazySingleton<ScanProductRepository>(
      () => ScanProductRepositoryImpl(serviceLocator()),
    )
    // Data Sources
    ..registerLazySingleton<ScanProductRemoteDataSource>(
      () => ScanProductRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // External dependencies
    ..registerLazySingleton(BarcodeScannerPlugin.new);
}

Future<void> _initRestaurants() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => RestaurantsBloc(
        getRestaurantsNearMe: serviceLocator(),
        getRestaurantDetails: serviceLocator(),
        getUserLocation: serviceLocator(),
        getRestaurantsMarkers: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => GetRestaurantsNearMe(serviceLocator()))
    ..registerLazySingleton(() => GetRestaurantDetails(serviceLocator()))
    ..registerLazySingleton(() => GetUserLocation(serviceLocator()))
    ..registerLazySingleton(() => GetRestaurantsMarkers(serviceLocator()))
    // Repositories
    ..registerLazySingleton<RestaurantsRepository>(
      () => RestaurantsRepositoryImpl(serviceLocator()),
    )
    // Data Sources

    ..registerLazySingleton<RestaurantsRemoteDataSource>(
      () => RestaurantsRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // External dependencies
    ..registerLazySingleton(LocationPlugin.new)
    ..registerLazySingleton(GoogleMapPlugin.new)
    ..registerLazySingleton(Client.new);
}
