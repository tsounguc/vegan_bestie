import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/exceptions.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:sheveegan/features/auth/data/models/user_model.dart';
import 'package:sheveegan/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repositoryImpl;
  late ForgotPasswordException testForgotPasswordException;
  late SignInWithEmailAndPasswordException testSignInException;
  late CreateWithEmailAndPasswordException testCreateUserException;
  late UserModel testModel;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImpl = AuthRepositoryImpl(remoteDataSource);
    testForgotPasswordException = const ForgotPasswordException(
      message: 'message',
      statusCode: '',
    );

    testSignInException = const SignInWithEmailAndPasswordException(
      message: 'message',
      statusCode: '500',
    );

    testCreateUserException = const CreateWithEmailAndPasswordException(
      message: 'message',
      statusCode: '500',
    );

    testModel = const UserModel.empty();
  });
  test(
    'given AuthRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [AuthRepository]',
    () {
      expect(repositoryImpl, isA<AuthRepository>());
    },
  );

  const testEmail = 'tsounguc@mail.gvsu.edu';
  const testPassword = '12345678';
  const testFullName = 'Christian Tsoungui Nkoulou';

  group('forgotPassword - ', () {
    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.forgotPassword] is called '
      'then complete call to remote data source successfully ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.forgotPassword(email: any(named: 'email')),
        ).thenAnswer((_) async => Future.value());
        // Act
        final result = await repositoryImpl.forgotPassword(
          email: testEmail,
        );
        // Assert
        expect(
          result,
          equals(const Right<Failure, void>(null)),
        );
        verify(
          () => remoteDataSource.forgotPassword(email: testEmail),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.forgotPassword] is called '
      'and remote data source call is unsuccessful '
      'then return [ForgotPasswordFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.forgotPassword(email: testEmail),
        ).thenThrow(testForgotPasswordException);
        // Act
        final result = await repositoryImpl.forgotPassword(
          email: testEmail,
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, void>(
              ForgotPasswordFailure.fromException(testForgotPasswordException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.forgotPassword(email: testEmail),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signInWithEmailAndPassword - ', () {
    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.signInWithEmailAndPassword] is called '
      'then complete call to remote data source successfully '
      'and return [UserEntity]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => testModel);
        // Act
        final result = await repositoryImpl.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        );
        // Assert
        expect(
          result,
          equals(Right<Failure, UserEntity>(testModel)),
        );
        verify(
          () => remoteDataSource.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.signInWithEmailAndPassword] is called '
      'and remote data source call is unsuccessful '
      'then return [SignInWithEmailAndPasswordFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(testSignInException);
        // Act
        final result = await repositoryImpl.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, UserEntity>(
              SignInWithEmailAndPasswordFailure.fromException(
                testSignInException,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('createUserAccount - ', () {
    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.createUserAccount] is called '
      'then complete call to remote data source successfully '
      'and return [UserEntity]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUserAccount(
            fullName: any(named: 'fullName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => testModel);
        // Act
        final result = await repositoryImpl.createUserAccount(
          email: testEmail,
          password: testPassword,
          userName: testFullName,
        );
        // Assert
        expect(
          result,
          equals(Right<Failure, UserEntity>(testModel)),
        );
        verify(
          () => remoteDataSource.createUserAccount(
            fullName: any(named: 'fullName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given AuthRepositoryImpl, '
      'when [AuthRepositoryImpl.createUserAccount] is called '
      'and remote data source call is unsuccessful '
      'then return [CreateWithEmailAndPasswordFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUserAccount(
            fullName: any(named: 'fullName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(testCreateUserException);
        // Act
        final result = await repositoryImpl.createUserAccount(
          email: 'testEmail',
          password: 'testPassword',
          userName: 'testFullName',
        );
        // Assert
        expect(
          result,
          equals(
            Left<Failure, UserEntity>(
              CreateWithEmailAndPasswordFailure.fromException(
                testCreateUserException,
              ),
            ),
          ),
        );
        verify(
          () => remoteDataSource.createUserAccount(
            fullName: any(named: 'fullName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
