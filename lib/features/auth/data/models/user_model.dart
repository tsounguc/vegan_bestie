import 'dart:convert';

import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
    super.bio,
    super.veganStatus,
    super.savedProductsBarcodes,
    super.savedRestaurantsIds,
  });

  const UserModel.empty()
      : this(
          uid: '_empty.uid',
          name: '_empty.fullName',
          email: '_empty.email',
          photoUrl: null,
          bio: null,
          veganStatus: null,
          savedRestaurantsIds: const [],
          savedProductsBarcodes: const [],
        );

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        jsonDecode(source) as DataMap,
      );

  UserModel.fromMap(DataMap dataMap)
      : this(
          uid: dataMap['uid'] as String,
          name: dataMap['fullName'] as String? ?? '',
          email: dataMap['email'] as String,
          photoUrl: dataMap['photoUrl'] as String?,
          bio: dataMap['bio'] as String?,
          veganStatus: dataMap['veganStatus'] as String?,
          savedProductsBarcodes: dataMap['savedProductsBarcodes'] == null
              ? []
              : List<String>.from(
                  (dataMap['savedProductsBarcodes'] as List).map(
                    (foodProductId) => foodProductId,
                  ),
                ),
          savedRestaurantsIds: dataMap['savedRestaurantsIds'] == null
              ? []
              : List<String>.from(
                  (dataMap['savedRestaurantsIds'] as List).map(
                    (foodProductId) => foodProductId,
                  ),
                ),
        );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
        'uid': uid,
        'fullName': name,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'veganStatus': veganStatus,
        'savedProductsBarcodes': savedProductsBarcodes,
        'savedRestaurantsIds': savedRestaurantsIds,
      };

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    String? veganStatus,
    List<String>? savedProductsBarcodes,
    List<String>? savedRestaurantsIds,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      veganStatus: veganStatus ?? this.veganStatus,
      savedProductsBarcodes: savedProductsBarcodes ?? this.savedProductsBarcodes,
      savedRestaurantsIds: savedRestaurantsIds ?? this.savedRestaurantsIds,
    );
  }
}
