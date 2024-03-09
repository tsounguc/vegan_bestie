import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/features/restaurants/domain/entities/user_location.dart';

class UserLocationModel extends UserLocation {
  const UserLocationModel({required super.position});

  UserLocationModel.empty()
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

  UserLocationModel copyWith({Position? position}) {
    return UserLocationModel(position: position ?? this.position);
  }
}
