import 'package:equatable/equatable.dart';
import 'package:sheveegan/core/use_case/use_case.dart';
import 'package:sheveegan/core/utils/typedefs.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class SendEmail extends UseCaseWithParams<void, SendEmailParams> {
  const SendEmail(this._repository);

  final AuthRepository _repository;

  @override
  ResultVoid call(SendEmailParams params) => _repository.sendEmail(
        subject: params.subject,
        body: params.body,
      );
}

class SendEmailParams extends Equatable {
  const SendEmailParams({
    required this.subject,
    required this.body,
  });

  const SendEmailParams.empty()
      : this(
          subject: '',
          body: '',
        );

  final String subject;
  final String body;

  @override
  List<Object?> get props => [
        subject,
        body,
      ];
}
