part of 'service_locator.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initAuth();
  await _initScan();
  await _initRestaurants();
  await _initNotification();
}

Future<void> _initNotification() async {
  serviceLocator
    ..registerFactory(
      () => NotificationCubit(
        clear: serviceLocator(),
        clearAll: serviceLocator(),
        getNotifications: serviceLocator(),
        markAsRead: serviceLocator(),
        sendNotification: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => Clear(serviceLocator()))
    ..registerLazySingleton(() => ClearAll(serviceLocator()))
    ..registerLazySingleton(() => GetNotifications(serviceLocator()))
    ..registerLazySingleton(() => MarkAsRead(serviceLocator()))
    ..registerLazySingleton(() => SendNotification(serviceLocator()))
    ..registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton<NotificationRemoteDatasource>(
      () => NotificationRemoteDatasourceImpl(
        firestore: serviceLocator(),
        auth: serviceLocator(),
      ),
    );
}

Future<void> _initAuth() async {
  final prefs = await SharedPreferences.getInstance();

  serviceLocator
    // App Logic
    ..registerFactory(
      () => AuthBloc(
        signInWithEmailAndPassword: serviceLocator(),
        createUserAccount: serviceLocator(),
        forgotPassword: serviceLocator(),
        updateUser: serviceLocator(),
        sendEmail: serviceLocator(),
        deleteProfilePic: serviceLocator(),
        deleteAccount: serviceLocator(),
        getCurrentUser: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => SignInWithEmailAndPassword(serviceLocator()))
    ..registerLazySingleton(() => CreateUserAccount(serviceLocator()))
    ..registerLazySingleton(() => ForgotPassword(serviceLocator()))
    ..registerLazySingleton(() => UpdateUser(serviceLocator()))
    ..registerLazySingleton(() => SendEmail(serviceLocator()))
    ..registerLazySingleton(() => DeleteProfilePicture(serviceLocator()))
    ..registerLazySingleton(() => DeleteAccount(serviceLocator()))
    ..registerLazySingleton(() => GetCurrentUser(serviceLocator()))
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
    ..registerLazySingleton(() => FirebaseStorage.instance)
    ..registerLazySingleton(() => prefs);
}

Future<void> _initScan() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => FoodProductCubit(
        scanBarcode: serviceLocator(),
        fetchProduct: serviceLocator(),
        saveFoodProduct: serviceLocator(),
        unSaveFoodProduct: serviceLocator(),
        fetchSavedProductsList: serviceLocator(),
        readIngredientsFromImage: serviceLocator(),
        updateFoodProduct: serviceLocator(),
        addFoodProduct: serviceLocator(),
        reportIssue: serviceLocator(),
        fetchReports: serviceLocator(),
        deleteReport: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ScanBarcode(serviceLocator()))
    ..registerLazySingleton(() => FetchProduct(serviceLocator()))
    ..registerLazySingleton(() => SaveFoodProduct(serviceLocator()))
    ..registerLazySingleton(() => UnSaveFoodProduct(serviceLocator()))
    ..registerLazySingleton(() => FetchSavedProductsList(serviceLocator()))
    ..registerLazySingleton(() => ReadIngredientsFromImage(serviceLocator()))
    ..registerLazySingleton(() => UpdateFoodProduct(serviceLocator()))
    ..registerLazySingleton(() => AddFoodProduct(serviceLocator()))
    ..registerLazySingleton(() => ReportIssue(serviceLocator()))
    ..registerLazySingleton(() => FetchReports(serviceLocator()))
    ..registerLazySingleton(() => DeleteReport(serviceLocator()))

    // Repositories
    ..registerLazySingleton<FoodProductRepository>(
      () => FoodProductRepositoryImpl(serviceLocator()),
    )
    // Data Sources
    ..registerLazySingleton<FoodProductRemoteDataSource>(
      () => FoodProductRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // External dependencies
    ..registerLazySingleton(BarcodeScannerPlugin.new)
    ..registerLazySingleton(VeganChecker.new);
}

Future<void> _initRestaurants() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => RestaurantsCubit(
        getRestaurantsNearMe: serviceLocator(),
        addRestaurant: serviceLocator(),
        submitRestaurant: serviceLocator(),
        addRestaurantReview: serviceLocator(),
        deleteRestaurantReview: serviceLocator(),
        deleteRestaurantSubmission: serviceLocator(),
        editRestaurantReview: serviceLocator(),
        updateRestaurant: serviceLocator(),
        saveRestaurant: serviceLocator(),
        unSaveRestaurant: serviceLocator(),
        getSavedRestaurants: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLocationCubit(
        getUserLocation: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => MapCubit(
        getRestaurantsMarkers: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => AddRestaurant(serviceLocator()))
    ..registerLazySingleton(() => SubmitRestaurant(serviceLocator()))
    ..registerLazySingleton(() => GetRestaurantsNearMe(serviceLocator()))
    ..registerLazySingleton(() => UpdateRestaurant(serviceLocator()))
    // ..registerLazySingleton(() => GetRestaurantDetails(serviceLocator()))
    ..registerLazySingleton(() => GetUserLocation(serviceLocator()))
    ..registerLazySingleton(() => GetRestaurantsMarkers(serviceLocator()))
    ..registerLazySingleton(() => SaveRestaurant(serviceLocator()))
    ..registerLazySingleton(() => UnSaveRestaurant(serviceLocator()))
    ..registerLazySingleton(() => GetSavedRestaurants(serviceLocator()))
    ..registerLazySingleton(() => AddRestaurantReview(serviceLocator()))
    // ..registerLazySingleton(() => GetRestaurantReviews(serviceLocator()))
    ..registerLazySingleton(() => DeleteRestaurantReview(serviceLocator()))
    ..registerLazySingleton(() => DeleteRestaurantSubmission(serviceLocator()))
    ..registerLazySingleton(() => EditRestaurantReview(serviceLocator()))
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
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        // serviceLocator(),
      ),
    )
    // External dependencies
    ..registerLazySingleton(LocationPlugin.new)
    ..registerLazySingleton(GoogleMapPlugin.new)
    ..registerLazySingleton(Client.new)
    ..registerLazySingleton(GeocodingPlugin.new);
}
