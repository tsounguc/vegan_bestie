import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';
import 'package:sheveegan/features/restaurants/domain/repositories/restaurants_repository.dart';

class GetUserLocation extends UseCase<UserLocation> {
  const GetUserLocation(this._repository);

  final RestaurantsRepository _repository;

  @override
  ResultFuture<UserLocation> call() async => _repository.getUserLocation();
}
