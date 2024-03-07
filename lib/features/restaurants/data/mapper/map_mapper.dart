import '../../domain/entities/map_entity.dart';
import '../models/map_model.dart';

class MapMapper {
  MapEntity mapToEntity(MapModel mapModel) {
    return MapEntity(markers: mapModel.restaurantsMarkers);
  }
}
