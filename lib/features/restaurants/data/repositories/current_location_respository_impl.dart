import 'package:dartz/dartz.dart';
import 'package:sheveegan/features/restaurants/data/mapper/location_mapper.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories_contracts/current_location_repository_contract.dart';
import '../data_sources/current_location_from_plugin.dart';
import '../models/location_model.dart';

class CurrentLocationRepositoryImpl implements CurrentLocationRepositoryContract {
  CurrentLocationFromPluginContract currentLocationFromPluginContract =
      serviceLocator<CurrentLocationFromPluginContract>();

  @override
  Future<Either<LocationFailure, LocationEntity>> getCurrentLocation() async {
    try {
      LocationModel locationModel = await currentLocationFromPluginContract.getCurrentLocation();
      LocationMapper mapper = LocationMapper();
      LocationEntity locationEntity = mapper.mapToEntity(locationModel);
      return Right(locationEntity);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    }
  }

  @override
  Future<Either<LocationFailure, LocationEntity>> getLastLocation() async {
    try {
      LocationModel locationModel = await currentLocationFromPluginContract.getLastLocation();
      LocationMapper mapper = LocationMapper();
      LocationEntity locationEntity = mapper.mapToEntity(locationModel);
      return Right(locationEntity);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    }
  }
}
