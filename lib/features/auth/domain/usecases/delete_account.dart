import 'package:flutter/cupertino.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccount implements UseCaseWithParams<void, String> {
  const DeleteAccount(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) async => _repository.deleteAccount(password: params);
}
