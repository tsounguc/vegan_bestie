import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sheveegan/features/restaurants/domain/usecases/get_user_location.dart';

part 'user_location_state.dart';

class UserLocationCubit extends Cubit<UserLocationState> {
  UserLocationCubit({
    required GetUserLocation getUserLocation,
  })  : _getUserLocation = getUserLocation,
        super(UserLocationInitial());
  final GetUserLocation _getUserLocation;
  Position? lastUserLocation;

  Future<void> loadGeoLocation() async {
    if (state is UserLocationInitial) emit(const LoadingUserGeoLocation());
    final result = await _getUserLocation();
    result.fold(
      (failure) => emit(UserLocationError(message: failure.errorMessage)),
      (userLocation) {
        final locationChanged = checkLocation(lastUserLocation, userLocation.position);
        if (locationChanged) {
          lastUserLocation = userLocation.position;
          emit(
            UserLocationLoaded(position: userLocation.position),
          );
        }
      },
    );
  }

  bool checkLocation(
    Position? userLocation,
    Position newPosition,
  ) {
    return userLocation == null ||
        userLocation.latitude.toStringAsFixed(3) !=
            newPosition.latitude.toStringAsFixed(
              3,
            ) ||
        userLocation.longitude.toStringAsFixed(3) !=
            newPosition.longitude.toStringAsFixed(
              3,
            );
  }
}
