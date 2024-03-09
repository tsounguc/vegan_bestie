import 'package:dartz/dartz.dart';

import '../../../../core/failures_successes/failures.dart';
import '../entities/user_location.dart';

abstract class CurrentLocationRepositoryContract {
  Future<Either<UserLocationFailure, UserLocation>> getCurrentLocation();

  Future<Either<UserLocationFailure, UserLocation>> getLastLocation();
}
