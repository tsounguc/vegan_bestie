import '../../domain/entities/location_entity.dart';
import '../models/location_model.dart';

class LocationMapper {
  LocationEntity mapToEntity(LocationModel locationModel) {
    return LocationEntity(position: locationModel.position);
  }
}
