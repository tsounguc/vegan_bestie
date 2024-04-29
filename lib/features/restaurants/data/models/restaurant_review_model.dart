import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_review.dart';

class RestaurantReviewModel extends RestaurantReview {
  const RestaurantReviewModel({
    required super.id,
    required super.title,
    required super.review,
    required super.rating,
    required super.createdAt,
    required super.updatedAt,
    required super.restaurantId,
    required super.username,
    required super.userId,
    required super.userProfilePic,
  });

  RestaurantReviewModel.empty()
      : this(
    id: '_empty.id',
    title: '_empty.title',
    review: '_empty.review',
    rating: 0,
    createdAt: DateTime.timestamp(),
    updatedAt: DateTime.timestamp(),
    restaurantId: '_empty.restaurantId',
    username: '_empty.username',
    userId: '_empty.userId',
    userProfilePic: '_empty.userProfilePic',
  );

  RestaurantReviewModel.fromMap(DataMap map)
      : this(
    id: map['id'] as String,
    title: map['title'] as String,
    review: map['review'] as String,
    rating: (map['rating'] as num).toDouble(),
    createdAt: (map['createdAt'] as Timestamp).toDate(),
    updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    restaurantId: map['restaurantId'] as String,
    userId: map['userId'] as String,
    username: map['username'] as String,
    userProfilePic: map['userProfilePic'] as String,
  );

  RestaurantReviewModel copyWith({
    String? id,
    String? title,
    String? review,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    String? userId,
    String? userProfilePic,
    String? restaurantId,
  }) {
    return RestaurantReviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      restaurantId: restaurantId ?? this.restaurantId,
      username: username ?? this.username,
      userId: userId ?? this.userId,
      userProfilePic: userProfilePic ?? this.userProfilePic,
    );
  }

  DataMap toMap() =>
      {
        'id': id,
        'title': title,
        'review': review,
        'rating': rating,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'restaurantId': restaurantId,
        'username': username,
        'userId': userId,
        'userProfilePic': userProfilePic,
      };
}
