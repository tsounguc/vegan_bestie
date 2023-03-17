import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/location_entity.dart';


abstract class CurrentLocationRepositoryContract {
  Future<Either<LocationFailure, LocationEntity>> getCurrentLocation();
}