import 'package:equatable/equatable.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantSubmit extends Equatable {
  const RestaurantSubmit({
    required this.id,
    required this.userId,
    required this.userName,
    required this.submittedRestaurant,
    required this.submittedAt,
  });

  RestaurantSubmit.empty()
      : this(
          id: '_empty.id',
          userId: '_empty.userId',
          userName: '_empty.userName',
          submittedRestaurant: const Restaurant.empty(),
          submittedAt: DateTime.timestamp(),
        );

  final String id;
  final String userId;
  final String userName;
  final Restaurant submittedRestaurant;
  final DateTime submittedAt;

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, userName, submittedRestaurant, submittedAt];
}
