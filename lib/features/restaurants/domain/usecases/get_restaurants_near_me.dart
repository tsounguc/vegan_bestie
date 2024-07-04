import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetRestaurantsNearMe extends StreamUseCaseWithParams<List<Restaurant>, GetRestaurantsNearMeParams> {
  const GetRestaurantsNearMe(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultStream<List<Restaurant>> call(GetRestaurantsNearMeParams params) =>
      _repository.getRestaurantsNearMe(position: params.position, radius: params.radius);

// @override
// ResultFuture<List<Restaurant>> call(
//   GetRestaurantsNearMeParams params,
// ) async =>
//     _repository.getRestaurantsNearMe(
//       position: params.position,
//       radius: params.radius,
//     );
}

class GetRestaurantsNearMeParams extends Equatable {
  const GetRestaurantsNearMeParams({
    required this.position,
    required this.radius,
  });

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
          radius: 1609,
        );

  final Position position;
  final double radius;

  @override
  List<Object?> get props => [position, radius];
}
