import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';

class UserMapper {
  UserEntity mapToEntity(UserModel userModel) {
    return UserEntity(
      uid: userModel.uid,
      name: userModel.name,
      email: userModel.email,
      photoUrl: userModel.photoUrl,
    );
  }
}
