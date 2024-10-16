import 'package:equatable/equatable.dart';

class RestaurantReview extends Equatable {
  const RestaurantReview({
    required this.id,
    required this.title,
    required this.text,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantId,
    required this.userId,
    // required this.username,
    // required this.userProfilePic,
  });

  RestaurantReview.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          text: '_empty.id',
          rating: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          restaurantId: '_empty.restaurantId',
          // username: '_empty.username',
          userId: '_empty.userId',
          // userProfilePic: '_empty.userProfilePic',
        );

  final String id;
  final String title;
  final String text;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String restaurantId;

  // final String username;
  final String userId;

  // final String userProfilePic;

  @override
  List<Object?> get props => [
        id,
        title,
        text,
        rating,
        createdAt,
        updatedAt,
        restaurantId,
        // username,
        userId,
        // userProfilePic,
      ];
}
