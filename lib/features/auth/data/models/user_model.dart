import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.photoUrl,
    super.bio,
  });

  const UserModel.empty()
      : this(
          uid: '',
          name: '',
          email: '',
        );

  UserModel.fromMap(DataMap map)
      : this(
          uid: map['uid'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          photoUrl: map['photoUrl'] as String?,
          bio: map['bio'] as String?,
        );

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
    );
  }
}
