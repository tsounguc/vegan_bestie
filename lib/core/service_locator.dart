import 'package:get_it/get_it.dart';
import 'package:sheveegan/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sheveegan/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:sheveegan/features/auth/domain/repositories_contracts/auth_repository_contract.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password_usecases.dart';
import 'package:sheveegan/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/scan_product/data/data_sources/fetch_product_from_remote_data_source.dart';
import '../features/scan_product/data/data_sources/scan_barcode_from_plugin.dart';
import '../features/scan_product/data/repositories_impl/fetch_product_repository_impl.dart';
import '../features/scan_product/data/repositories_impl/scan_barcode_repository_impl.dart';
import '../features/scan_product/domain/repositories_contracts/fetch_product_repository_contract.dart';
import '../features/scan_product/domain/repositories_contracts/scan_barcode_repository_contract.dart';
import '../features/scan_product/domain/usescases/fetch_product_usecase.dart';
import '../features/scan_product/domain/usescases/scan_barcode_usecase.dart';
import 'services/auth_service.dart';
import 'services/barcode_scanner_plugin.dart';
import 'services/food_facts_api_service.dart';

final GetIt serviceLocator = GetIt.instance;

void setUpServices() {
  //--- Auth Service
  serviceLocator.registerSingleton<AuthServiceContract>(AuthServiceImpl());
  serviceLocator.registerSingleton<AuthRemoteDataSourceContract>(AuthRemoteDataSourceImpl());
  serviceLocator.registerSingleton<AuthRepositoryContract>(AuthRepositoryImpl());
  serviceLocator.registerSingleton<CreateUserAccountUseCase>(CreateUserAccountUseCase());
  serviceLocator.registerSingleton<SignOutUseCase>(SignOutUseCase());
  serviceLocator.registerSingleton<CurrentUserUseCase>(CurrentUserUseCase());
  serviceLocator.registerSingleton<SignInWithEmailAndPasswordUseCase>(SignInWithEmailAndPasswordUseCase());

  //--- Food Service
  serviceLocator.registerSingleton<FoodFactsApiServiceContract>(FoodFactsApiServiceImpl());
  serviceLocator
      .registerSingleton<FetchProductFromRemoteDataSourceContract>(FetchProductFromRemoteDataSourceImpl());
  serviceLocator.registerSingleton<FetchProductRepositoryContract>(FetchProductRepositoryImpl());
  serviceLocator.registerSingleton<FetchProductUseCase>(FetchProductUseCase());
  //--- Scanner Service
  serviceLocator.registerSingleton<BarcodeScannerServiceContract>(BarcodeScannerServiceImpl());
  serviceLocator.registerSingleton<ScanBarcodeFromPluginContract>(ScanBarcodeFromPluginImpl());
  serviceLocator.registerSingleton<ScanBarcodeRepositoryContract>(ScanBarcodeRepositoryImpl());
  serviceLocator.registerSingleton<ScanBarcodeUseCase>(ScanBarcodeUseCase());
}
