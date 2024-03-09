import 'package:dartz/dartz.dart';
import 'package:sheveegan/features/restaurants/data/mapper/location_mapper.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/repositories_contracts/current_location_repository_contract.dart';
import '../data_sources/current_location_from_plugin.dart';
import '../models/user_location_model.dart';

class CurrentLocationRepositoryImpl implements CurrentLocationRepositoryContract {
  CurrentLocationFromPluginContract currentLocationFromPluginContract =
      serviceLocator<CurrentLocationFromPluginContract>();

  @override
  Future<Either<UserLocationFailure, UserLocation>> getCurrentLocation() async {
    try {
      UserLocationModel locationModel = await currentLocationFromPluginContract.getCurrentLocation();
      LocationMapper mapper = LocationMapper();
      UserLocation locationEntity = mapper.mapToEntity(locationModel);
      return Right(locationEntity);
    } on UserLocationException catch (e) {
      return Left(UserLocationFailure(message: e.message));
    }
  }

  @override
  Future<Either<UserLocationFailure, UserLocation>> getLastLocation() async {
    try {
      UserLocationModel locationModel = await currentLocationFromPluginContract.getLastLocation();
      LocationMapper mapper = LocationMapper();
      UserLocation locationEntity = mapper.mapToEntity(locationModel);
      return Right(locationEntity);
    } on UserLocationException catch (e) {
      return Left(UserLocationFailure(message: e.message));
    }
  }
}
