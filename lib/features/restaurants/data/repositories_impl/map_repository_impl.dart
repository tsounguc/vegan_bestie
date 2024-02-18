import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/exceptions.dart';
import '../../../../core/failures_successes/failures.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/map_entity.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repositories_contracts/map_repository_contract.dart';
import '../data_sources/map_info_from_remote_data_source_contract.dart';
import '../mapper/map_mapper.dart';
import '../models/map_model.dart';

class MapRepositoryImpl implements MapRepositoryContract {
  MapInfoFromRemoteDataSourceContract mapInfoFromRemoteDataSourceContract =
      serviceLocator<MapInfoFromRemoteDataSourceContract>();

  @override
  Future<Either<MapFailure, MapEntity>> getRestaurantsMarkers(List<RestaurantEntity> restaurants) async {
    try {
      MapModel mapModel = await mapInfoFromRemoteDataSourceContract.getRestaurantsModels(restaurants);
      MapMapper mapper = MapMapper();
      MapEntity mapEntity = mapper.mapToEntity(mapModel);
      return Right(mapEntity);
    } on MapException catch (e) {
      return Left(MapFailure(message: e.message));
    }
  }
}
