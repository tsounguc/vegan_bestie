import 'package:equatable/equatable.dart';

class RestaurantReview extends Equatable {
  const RestaurantReview({
    required this.id,
    required this.title,
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantId,
    required this.username,
    required this.userProfilePic,
  });

  RestaurantReview.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          review: '_empty.id',
          rating: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          restaurantId: '_empty.restaurantId',
          username: '_empty.username',
          userProfilePic: '_empty.userProfilePic',
        );

  final String id;
  final String title;
  final String review;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String restaurantId;
  final String username;
  final String userProfilePic;

  @override
  List<Object?> get props => [
        id,
        title,
        review,
        rating,
        createdAt,
        updatedAt,
        restaurantId,
        username,
        userProfilePic,
      ];
}
