import '../../domain/entities/user_location.dart';
import '../models/user_location_model.dart';

class LocationMapper {
  UserLocation mapToEntity(UserLocationModel locationModel) {
    return UserLocation(position: locationModel.position);
  }
}
