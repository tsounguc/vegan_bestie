import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../../../../core/service_locator.dart';
import '../entities/location_entity.dart';
import '../repositories_contracts/current_location_repository_contract.dart';

class GetCurrentLocationUseCase {
  final CurrentLocationRepositoryContract _currentLocationRepositoryContract =
      serviceLocator<CurrentLocationRepositoryContract>();
  Future<Either<LocationFailure, LocationEntity>> getCurrentLocation() {
    return _currentLocationRepositoryContract.getCurrentLocation();
  }
}

class GetLastLocationUseCase {
  final CurrentLocationRepositoryContract _currentLocationRepositoryContract =
      serviceLocator<CurrentLocationRepositoryContract>();
  Future<Either<LocationFailure, LocationEntity>> getLastLocation() {
    return _currentLocationRepositoryContract.getLastLocation();
  }
}
