import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class DeleteProfilePicture implements UseCaseWithParams<void, UserEntity?> {
  const DeleteProfilePicture(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(UserEntity? params) async => _repository.deleteProfilePicture(user: params);
}
