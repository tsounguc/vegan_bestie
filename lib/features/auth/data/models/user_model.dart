import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
    super.bio,
    super.savedProductsBarcodes,
    super.savedRestaurantsIds,
  });

  const UserModel.empty()
      : this(
          uid: '',
          name: '',
          email: '',
          savedRestaurantsIds: const [],
          savedProductsBarcodes: const [],
        );

  UserModel.fromMap(DataMap dataMap)
      : this(
          uid: dataMap['uid'] as String,
          name: dataMap['fullName'] as String,
          email: dataMap['email'] as String,
          photoUrl: dataMap['photoUrl'] as String?,
          bio: dataMap['bio'] as String?,
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

  DataMap toMap() => {
        'uid': uid,
        'fullName': name,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'savedProductsBarcodes': savedProductsBarcodes,
        'savedRestaurantsIds': savedRestaurantsIds,
      };

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    List<String>? savedProductsBarcodes,
    List<String>? savedRestaurantsIds,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      savedProductsBarcodes: savedProductsBarcodes ?? this.savedProductsBarcodes,
      savedRestaurantsIds: savedRestaurantsIds ?? this.savedRestaurantsIds,
    );
  }
}
