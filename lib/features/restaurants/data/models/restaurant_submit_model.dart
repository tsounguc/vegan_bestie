import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/restaurants/data/models/restaurant_model.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant_submit.dart';

class RestaurantSubmitModel extends RestaurantSubmit {
  const RestaurantSubmitModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.submittedRestaurant,
    required super.submittedAt,
  });

  RestaurantSubmitModel.empty()
      : this(
    id: '_empty.id',
    userId: '_empty.userId',
    userName: '_empty.userName',
    submittedRestaurant: const RestaurantModel.empty(),
    submittedAt: DateTime.timestamp(),
  );

  factory RestaurantSubmitModel.fromJson(String source) =>
      RestaurantSubmitModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  RestaurantSubmitModel.fromMap(DataMap dataMap)
      : this(
    id: dataMap['id'] == null ? '' : dataMap['id'] as String,
    userId: dataMap['userId'] == null ? '' : dataMap['userId'] as String,
    userName: dataMap['userName'] == null ? '' : dataMap['userName'] as String,
    submittedRestaurant: dataMap['submittedRestaurant'] != null
        ? RestaurantModel.fromMap(dataMap['submittedRestaurant'] as DataMap)
        : const RestaurantModel.empty(),
    submittedAt: (dataMap['submittedAt'] as Timestamp).toDate(),
  );

  RestaurantSubmitModel copyWith({
    String? id,
    String? userId,
    String? userName,
    RestaurantModel? submittedRestaurant,
    DateTime? submittedAt,
  }) {
    return RestaurantSubmitModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      submittedRestaurant: submittedRestaurant ?? this.submittedRestaurant,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  DataMap toMap() =>
      {
        'id': id,
        'userId': userId,
        'userName': userName,
        'submittedRestaurant': (submittedRestaurant as RestaurantModel).toMap(),
        'submittedAt': submittedAt,
      };
}
