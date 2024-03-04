import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/repositories_contracts/restaurants_repository.dart';

class GetRestaurantsNearMe extends UseCaseWithParams<List<Restaurant>, GetRestaurantsNearMeParams> {
  const GetRestaurantsNearMe(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<List<Restaurant>> call(GetRestaurantsNearMeParams params) async =>
      _repository.getRestaurantsNearMe(position: params.position);
}

class GetRestaurantsNearMeParams extends Equatable {
  const GetRestaurantsNearMeParams({required this.position});

  GetRestaurantsNearMeParams.empty()
      : this(
          position: Position(
            longitude: 0,
            latitude: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            altitudeAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            speed: 0,
            speedAccuracy: 0,
          ),
        );

  final Position position;

  @override
  List<Object?> get props => [position];
}
