import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/map_entity.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetUserLocation extends UseCase<MapEntity> {
  const GetUserLocation(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<MapEntity> call() async => _repository.getUserLocation();
}

// class GetLastLocationUseCase {
//   final CurrentLocationRepositoryContract _currentLocationRepositoryContract =
//       serviceLocator<CurrentLocationRepositoryContract>();
//
//   Future<Either<LocationFailure, LocationEntity>> getLastLocation() {
//     return _currentLocationRepositoryContract.getLastLocation();
//   }
// }
