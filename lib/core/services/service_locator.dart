// import 'package:get_it/get_it.dart';
// import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
// import 'package:sheveegan/features/restaurants/data/data_sources/map_info_from_remote_data_source_contract.dart';
//
// import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
// import '../../features/auth/data/repository_impl/auth_repository_impl.dart';
// import '../../features/auth/domain/repositories_contracts/auth_repository.dart';
// import '../../features/auth/domain/usecases/create_with_email_and_password.dart';
// import '../../features/auth/domain/usecases/current_user_usecase.dart';
// import '../../features/auth/domain/usecases/sign_in_with_email_and_password.dart';
// import '../../features/auth/domain/usecases/sign_in_with_facebook_usecase.dart';
// import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
// import '../../features/auth/domain/usecases/sign_out_usecase.dart';
// import '../../features/restaurants/data/data_sources/current_location_from_plugin.dart';
// import '../../features/restaurants/data/data_sources/restaurant_details_from_remote_data_source.dart';
// import '../../features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
// import '../../features/restaurants/data/repositories_impl/current_location_respository_impl.dart';
// import '../../features/restaurants/data/repositories_impl/map_repository_impl.dart';
// import '../../features/restaurants/data/repositories_impl/restaurant_details_repository_impl.dart';
// import '../../features/restaurants/data/repositories_impl/restaurants_repository_impl.dart';
// import '../../features/restaurants/domain/repositories_contracts/current_location_repository_contract.dart';
// import '../../features/restaurants/domain/repositories_contracts/map_repository_contract.dart';
// import '../../features/restaurants/domain/repositories_contracts/restaurant_details_repository_contract.dart';
// import '../../features/restaurants/domain/repositories_contracts/restaurants_repository.dart';
// import '../../features/restaurants/domain/usecases/get_user_location.dart';
// import '../../features/restaurants/domain/usecases/get_restaurant_details.dart';
// import '../../features/restaurants/domain/usecases/get_restaurants_near_me.dart';
// import '../../features/restaurants/domain/usecases/get_restaurants_markers.dart';
// import '../../features/scan_product/data/data_sources/fetch_product_from_remote_data_source.dart';
// import '../../features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
//
// import '../../features/search/data/data_sources/search_products_from_remote_data_source.dart';
// import '../../features/search/data/repositories_impl/search_product_repository_impl.dart';
// import '../../features/search/domain/respositories_contracts/search_product_repository_contract.dart';
// import '../../features/search/domain/usecases/search_product_usecase.dart';
// import 'auth_service.dart';
// import 'barcode_scanner_plugin.dart';
// import 'food_facts_services/food_facts_api_service.dart';
// import 'restaurants_services/location_plugin.dart';
// import 'restaurants_services/restaurants_service.dart';
//
// final GetIt serviceLocator = GetIt.instance;
//
// void setUpServices() {
//   //--- Auth Service
//   serviceLocator.registerSingleton<AuthServiceContract>(FireBaseAuthServiceImpl());
//   serviceLocator.registerSingleton<AuthRemoteDataSourceContract>(AuthRemoteDataSourceImpl());
//   serviceLocator.registerSingleton<AuthRepositoryContract>(AuthRepositoryImpl());
//   serviceLocator.registerSingleton<CreateUserAccountUseCase>(CreateUserAccountUseCase());
//   serviceLocator.registerSingleton<SignOutUseCase>(SignOutUseCase());
//   serviceLocator.registerSingleton<CurrentUserUseCase>(CurrentUserUseCase());
//   serviceLocator.registerSingleton<SignInWithEmailAndPasswordUseCase>(SignInWithEmailAndPasswordUseCase());
//   serviceLocator.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());
//   serviceLocator.registerSingleton<SignInWithFacebookUseCase>(SignInWithFacebookUseCase());
//
//   //--- Scan Food Service
//   serviceLocator.registerSingleton<FoodFactsApiServiceContract>(OpenFoodFactsApiServiceImpl());
//   serviceLocator
//       .registerSingleton<FetchProductFromRemoteDataSourceContract>(FetchProductFromRemoteDataSourceImpl());
//   serviceLocator.registerSingleton<FetchProductRepositoryContract>(FetchProductRepositoryImpl());
//   serviceLocator.registerSingleton<FetchProduct>(FetchProduct());
//
//   //--- Search Food Service
//   // Currently uses the same api as scanner
//   serviceLocator
//       .registerSingleton<SearchProductsFromRemoteDataSourceContract>(SearchProductsFromRemoteDataSourceImpl());
//   serviceLocator.registerSingleton<SearchProductRepositoryContract>(SearchProductRepositoryImpl());
//   serviceLocator.registerSingleton<SearchProductUseCase>(SearchProductUseCase());
//
//   //--- Scanner Service
//   serviceLocator.registerSingleton<BarcodeScannerServiceContract>(BarcodeScannerServiceImpl());
//   serviceLocator.registerSingleton<ScanProductRemoteDataSource>(ScanBarcodeFromPluginImpl());
//   serviceLocator.registerSingleton<ScanProductRepository>(ScanBarcodeRepositoryImpl());
//   serviceLocator.registerSingleton<ScanBarcode>(ScanBarcode());
//
//   //--- GeoLocator
//   serviceLocator.registerSingleton<CurrentLocationPluginContract>(CurrentLocationPluginImpl());
//   serviceLocator.registerSingleton<CurrentLocationFromPluginContract>(CurrentLocationFromGeoLocatorPluginImpl());
//   serviceLocator.registerSingleton<CurrentLocationRepositoryContract>(CurrentLocationRepositoryImpl());
//   serviceLocator.registerSingleton<GetCurrentLocationUseCase>(GetCurrentLocationUseCase());
//   serviceLocator.registerSingleton<GetLastLocationUseCase>(GetLastLocationUseCase());
//
//   //--- Restaurants Service
//   // serviceLocator.registerSingleton<RestaurantsApiServiceContract>(YelpFusionRestaurantsApiServiceImpl());
//   serviceLocator.registerSingleton<RestaurantsApiServiceContract>(GooglePlacesRestaurantsApiServiceImpl());
//
//   // serviceLocator
//   //     .registerSingleton<RestaurantsFromRemoteDataSourceContract>(RestaurantsFromRemoteDataSourceYelpImpl());
//   serviceLocator
//       .registerSingleton<RestaurantsFromRemoteDataSourceContract>(RestaurantsFromRemoteDataSourceGoogleImpl());
//
//   // serviceLocator.registerSingleton<RestaurantDetailsFromRemoteDataSourceContract>(
//   //     RestaurantDetailsFromRemoteDataSourceYelpImpl());
//   serviceLocator.registerSingleton<RestaurantDetailsFromRemoteDataSourceContract>(
//       RestaurantDetailsFromRemoteDataSourceGoogleImpl());
//
//   // serviceLocator.registerSingleton<RestaurantsRepositoryContract>(RestaurantsRepositoryYelpImpl());
//   serviceLocator.registerSingleton<RestaurantsRepositoryContract>(RestaurantsRepositoryGoogleImpl());
//
//   // serviceLocator.registerSingleton<RestaurantDetailsRepositoryContract>(RestaurantDetailsRepositoryYelpImpl());
//   serviceLocator.registerSingleton<RestaurantDetailsRepositoryContract>(RestaurantDetailsRepositoryGoogleImpl());
//
//   serviceLocator.registerSingleton<GetRestaurantsNearMeUseCase>(GetRestaurantsNearMeUseCase());
//   serviceLocator.registerSingleton<GetRestaurantDetailsUseCase>(GetRestaurantDetailsUseCase());
//
//   //--- Map Service
//   serviceLocator.registerSingleton<MapServiceContract>(GoogleMapPluginImpl());
//   serviceLocator.registerSingleton<MapInfoFromRemoteDataSourceContract>(MapInfoFromRemoteDataSourceImpl());
//   serviceLocator.registerSingleton<MapRepositoryContract>(MapRepositoryImpl());
//   serviceLocator.registerSingleton<MapUseCase>(MapUseCase());
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:sheveegan/core/services/restaurants_services/barcode_scanner_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/location_plugin.dart';
import 'package:sheveegan/core/services/restaurants_services/map_plugin.dart';
import 'package:sheveegan/core/services/vegan_checker.dart';
import 'package:sheveegan/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sheveegan/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/forgot_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_food_product.dart';
import 'package:sheveegan/features/auth/domain/usecases/remove_restaurant.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_food_product.dart';
import 'package:sheveegan/features/auth/domain/usecases/save_restaurant.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/update_user.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:sheveegan/features/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/add_restaurant_review.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_details.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurant_reviews..dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_markers.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_restaurants_near_me.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';
import 'package:sheveegan/features/restaurants/presentation/restaurants_bloc/restaurants_bloc.dart';
import 'package:sheveegan/features/scan_product/data/data_sources/scan_product_remote_data_source.dart';
import 'package:sheveegan/features/scan_product/data/repositories/scan_product_repository_impl.dart';
import 'package:sheveegan/features/scan_product/domain/repositories/scan_product_repository.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_product.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/fetch_saved_products_list.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/get_saved_restaurants_list.dart';
import 'package:sheveegan/features/scan_product/domain/use_cases/scan_barcode.dart';
import 'package:sheveegan/features/scan_product/presentation/scan_product_cubit/scan_product_cubit.dart';

part 'service_locator.main.dart';
